//
//  JLImage.swift
//  JLImageDownloader
//
//  Created by James Lane on 8/15/24.
//

import SwiftUI

// MARK: - SwiftUI Bridge

struct JLImage: View {

    @State private var uiImage: UIImage? = nil
    var urlString: String
    var placeholderImage: String?

    var body: some View {
        Group {
            if let uiImage = uiImage {
                Image(uiImage: uiImage)
                    .resizable()
            } else {
                Image(placeholderImage ?? "")
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
            let image = await JLImageDownloader.shared.download(urlString: urlString)
            DispatchQueue.main.async {
                self.uiImage = image
            }
        }
    }
}
