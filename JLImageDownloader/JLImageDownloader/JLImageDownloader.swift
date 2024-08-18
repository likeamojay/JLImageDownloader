//
//  JLImageDownloader.swift
//  JLImageDownloader
//
//  Created by James Lane on 8/14/24.
//

import UIKit

internal class JLImageDownloader {
    
    static let shared = JLImageDownloader()
    
    private var cache = [String: UIImage]()
    private var downloadsInProgress = [String: Task<UIImage?, Never>]()
    private let cacheQueue = DispatchQueue(label: "com.JLImagedownloader.cacheQueue", attributes: .concurrent)
    
    func downloadImage(urlString: String) async -> UIImage? {
        
        // Check if the image is already in the cache
        let cachedImage = cacheQueue.sync {
            return cache[urlString]
        }
        if let cachedImage {
            return cachedImage
        }
        
        // Check if there is already an ongoing download for this URL
        if let existingTask = downloadsInProgress[urlString] {
            return await existingTask.value
        }
        
        // Ensure the URL is valid
        guard let url = URL(string: urlString) else {
            log(methodName: "download", message: "URL is nil")
            return nil
        }
        
        // Create a new download task
        let downloadTask = Task { () -> UIImage? in
            defer {
                // Remove the task from the ongoingTasks dictionary when done
                cacheQueue.async(flags: .barrier) {
                    self.downloadsInProgress[urlString] = nil
                }
            }
            
            do {
                let (data, response) = try await URLSession.shared.data(from: url)
    
                guard let image = UIImage(data: data) else {
                    log(methodName: "download", message: "Invalid image data from response: \(response.debugDescription)")
                    return nil
                }
                
                // Update the cache asynchronously
                cacheQueue.async(flags: .barrier) {
                    self.cache[urlString] = image
                }
                
                return image
            } catch let error as NSError {
                log(methodName: "download", message: "dataTask error: \(error.debugDescription)")
                return nil
            }
        }
        
        // Store the task in the ongoingTasks dictionary
        cacheQueue.async(flags: .barrier) {
            self.downloadsInProgress[urlString] = downloadTask
        }
        
        return await downloadTask.value
    }
    
    func clearCache() {
        cacheQueue.async(flags: .barrier) {
            self.cache.removeAll()
            self.downloadsInProgress.removeAll()
        }
    }
}

// MARK: - UIKit Extensions

extension UIImageView {
    
    public func setImage(urlString: String, placeholderImage: String? = nil) -> Void {
        if let placeholderImage {
            self.image = UIImage(named: placeholderImage)
        }
        Task.detached {
            let image = await JLImageDownloader.shared.downloadImage(urlString: urlString)
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

extension UIImage {

    public static func download(urlString: String) async -> UIImage? {
        return await JLImageDownloader.shared.downloadImage(urlString: urlString)
    }
}
