// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CMExtensions",
    platforms: [
        .iOS(.v14),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "UIKitPlus",
            targets: ["UIKitPlus"]
        ),
        .library(
            name: "CombinePlus",
            targets: ["CombinePlus"]
        ),
        .library(
            name: "CMExtensions",
            targets: ["CMExtensions"]
        ),
        .library(
            name: "FoundationPlus",
            targets: ["FoundationPlus"]
        ),
        .library(
            name: "DataStructures",
            targets: ["DataStructures"]
        ),
        .library(
            name: "AVFoundationPlus",
            targets: ["AVFoundationPlus"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/CombineCommunity/CombineCocoa.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/CombineCommunity/CombineExt",
            branch: "main"
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "CMExtensions"
        ),
        .target(name: "FoundationPlus"),
        .target(
            name: "DataStructures",
            dependencies: ["FoundationPlus"]
        ),
        .target(
            name: "AVFoundationPlus",
            dependencies: ["FoundationPlus"]
        ),
        .target(name: "COpenCombineHelpers"),
        .target(
            name: "CombinePlus",
            dependencies: [
                "CombineCocoa",
                "CombineExt",
                "COpenCombineHelpers"
            ]
        ),
        .target(
            name: "UIKitPlus"
        ),
        .testTarget(
            name: "CMExtensionsTests",
            dependencies: ["CMExtensions"]
        )
    ]
)
