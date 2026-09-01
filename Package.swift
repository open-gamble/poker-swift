// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PokerKit",
    platforms: [.iOS(.v17), .macOS(.v14)],
    products: [
        .library(name: "PokerKit", targets: ["PokerKit"]),
    ],
    targets: [
        .target(name: "PokerKit"),
        .testTarget(name: "PokerKitTests", dependencies: ["PokerKit"]),
    ]
)
