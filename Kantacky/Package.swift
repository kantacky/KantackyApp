// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Kantacky",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Account", targets: ["Account"]),
        .library(name: "Kantacky", targets: ["Kantacky"]),
        .library(name: "Models", targets: ["Models"]),
        .library(name: "SignIn", targets: ["SignIn"]),
        .library(name: "UserDefaultsClient", targets: ["UserDefaultsClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", .upToNextMajor(from: "1.0.0")),
    ],
    targets: [
        .target(
            name: "Account",
            dependencies: [
                "Models",
                "UserDefaultsClient",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ],
            plugins: []
        ),
        .target(
            name: "Kantacky",
            dependencies: [
                "Account",
                "SignIn",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            plugins: []
        ),
        .testTarget(
            name: "KantackyTests",
            dependencies: ["Kantacky"]
        ),
        .target(
            name: "Models",
            dependencies: [],
            plugins: []
        ),
        .target(
            name: "SignIn",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ],
            plugins: []
        ),
        .target(
            name: "UserDefaultsClient",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
            ],
            plugins: []
        )
    ]
)
