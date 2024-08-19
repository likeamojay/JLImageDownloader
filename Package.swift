// swift-tools-version: 5.8
import PackageDescription

let package = Package(
    name: "JLImageDownloader",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "JLImageDownloader",
            targets: ["JLImageDownloader"]
        ),
    ],
    dependencies: [
        // Add any dependencies if your framework relies on other packages
    ],
    targets: [
        .target(
            name: "JLImageDownloader",
            dependencies: [],
            path: "Sources",
            resources: [
                .process("Resources") // If you have resources
            ]
        ),
        .testTarget(
            name: "JLImageDownloaderTests",
            dependencies: ["JLImageDownloader"],
            path: "Tests"
        ),
    ]
)
