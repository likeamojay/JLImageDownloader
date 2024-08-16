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

    func downloadImage(urlString: String) async -> UIImage? {
        if let cachedImage = self.cache[urlString] {
            return cachedImage
        }

        guard let url = URL(string: urlString) else {
            log(methodName: "download", message: "URL is nil")
            return nil
        }
        
        let request = URLRequest(url: url)

        do {
            let task = try await URLSession.shared.data(for: request)
            let image = UIImage(data: task.0)
            if image == nil {
                log(methodName: "download", message: "response error \(task.1.debugDescription)")
                return nil
            }
            DispatchQueue.main.async {
                self.cache[urlString] = image
            }
            return image
        } catch let error as NSError {
            log(methodName: "download", message: "dataTask error \(error.debugDescription)")
            return nil
        }
    }
    
    func clearCache() {
        self.cache.removeAll()
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
