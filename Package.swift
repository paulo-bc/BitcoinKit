// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "YenomBitcoinKit",
    platforms: [
        .iOS(.v15),
        .macOS(.v13),
        .watchOS(.v8),
        .tvOS(.v15)
    ],
    products: [
        .library(
            name: "YenomBitcoinKit",
            targets: ["YenomBitcoinKit"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/krzyzanowskim/CryptoSwift.git",
            from: "1.8.0"
        ),
        .package(
            url: "https://github.com/Boilertalk/secp256k1.swift.git",
            from: "0.1.7"
        )
    ],
    targets: [
        .target(
            name: "YenomBitcoinKit",
            dependencies: [
                .product(name: "CryptoSwift", package: "CryptoSwift"),
                .product(name: "secp256k1", package: "secp256k1.swift")
            ],
            path: "Sources/BitcoinKit"
        ),
        .testTarget(
            name: "YenomBitcoinKitTests",
            dependencies: [
                .target(name: "YenomBitcoinKit")
            ],
            path: "Tests/BitcoinKitTests",
            resources: [
                .copy("Resources/block1.raw"),
                .copy("Resources/block413567.raw")
            ]
        )
    ]
)
