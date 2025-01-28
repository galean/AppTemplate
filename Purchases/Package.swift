// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "sk2-purchases",
    platforms: [
        .iOS(.v15),
    ],
    products: [
        .library(
            name: "Purchases",
            targets: ["Purchases"]
        )
    ],
    targets: [
        .target(
            name: "Purchases"
        )
    ]
)
