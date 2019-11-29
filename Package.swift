// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Alertify",
    products: [
        .library(name: "Alertify", targets: ["Alertify"]),
    ],
    dependencies: [ ],
    targets: [
        .target(name: "Alertify", dependencies: []),
        .testTarget(name: "AlertifyTests", dependencies: ["Alertify"]),
    ]
)
