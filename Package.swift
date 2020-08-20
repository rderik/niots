// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "niots",
    dependencies: [
         .package(url: "https://github.com/apple/swift-nio.git", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "niots",
            dependencies: [.product(name:"NIO", package: "swift-nio")]),
        .testTarget(
            name: "niotsTests",
            dependencies: ["niots"]),
    ]
)
