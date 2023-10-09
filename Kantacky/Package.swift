// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Kantacky",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "SignIn", targets: ["SignIn"]),
        .library(name: "Kantacky", targets: ["Kantacky"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "SignIn",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ],
            plugins: []
        ),
        .target(
            name: "Kantacky",
            dependencies: [
                "SignIn",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            plugins: []
        ),
        .testTarget(
            name: "KantackyTests",
            dependencies: ["Kantacky"]
        ),
    ]
)
