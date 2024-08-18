//
//  JLImage.swift
//  JLImageDownloader
//
//  Created by James Lane on 8/15/24.
//

import SwiftUI

// MARK: - SwiftUI Bridge

public struct JLImage: View {

    @State private var uiImage: UIImage? = nil
    private var urlString: String
    private var placeholderImage: String?
    
    public init(urlString: String, placeholderImage: String? = nil) {
        self.urlString = urlString
        self.placeholderImage = placeholderImage
    }

    public var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image(uiImage: UIImage(named: placeholderImage ?? "loading_icon", in: Bundle.jlImageDownloader, compatibleWith: nil) ?? UIImage())
                    .resizable()
                    .onAppear {
                        self.setImage()
                    }
            }
        }
    }

    private func setImage() {
        if let placeholderImage {
            self.uiImage = UIImage(named: placeholderImage)
        }

        Task.detached {
            let image = await JLImageDownloader.shared.downloadImage(urlString: urlString)
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }
    }
}
