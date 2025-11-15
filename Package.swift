// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MyBlog",
    platforms: [.macOS(.v13)],
    dependencies: [
        .package(url: "https://github.com/twostraws/Ignite.git", from: "0.6.0"),
    ],
    targets: [
        .executableTarget(
            name: "MyBlog",
            dependencies: ["Ignite"]),
    ]
)
