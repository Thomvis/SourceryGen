// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SourceryGen",
    platforms: [
        .macOS(.v10_15),
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .executable(name: "SourceryGenExample", targets: ["SourceryGenExample"]),
        .library(
            name: "SourceryGen",
            targets: ["SourceryGen"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(name: "Sourcery", url: "https://github.com/krzysztofzablocki/Sourcery.git", from: "1.3.1"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SourceryGenExample",
            dependencies: ["SourceryGen"]
        ),
        .target(
            name: "SourceryGen",
            dependencies: [
                .product(name: "SourceryFramework", package: "Sourcery")
            ]),
        .testTarget(
            name: "SourceryGenTests",
            dependencies: ["SourceryGen"]),
    ]
)
