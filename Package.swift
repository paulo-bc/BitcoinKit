// swift-tools-version: 5.6

import PackageDescription

let package = Package(
    name: "YenomBitcoinKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .watchOS(.v7),
        .tvOS(.v14)
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
            .upToNextMinor(from: "1.5.1")
        ),
        .package(
            url: "https://github.com/Boilertalk/secp256k1.swift.git",
            .upToNextMinor(from: "0.1.6")
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
    ],
    swiftLanguageVersions: [.v5]
)
