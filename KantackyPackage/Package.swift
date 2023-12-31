// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "KantackyPackage",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        .library(name: "Account", targets: ["Account"]),
        .library(name: "KantackyPackage", targets: ["KantackyPackage"]),
        .library(name: "SignIn", targets: ["SignIn"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.5.0")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", .upToNextMajor(from: "1.1.0")),
        .package(url: "https://github.com/apple/swift-format.git", .upToNextMajor(from: "509.0.0")),
        .package(url: "https://github.com/auth0/Auth0.swift.git", .upToNextMajor(from: "2.5.0")),
        .package(url: "https://github.com/kean/Nuke.git", .upToNextMajor(from: "12.2.0")),
    ],
    targets: [
        .target(
            name: "Account",
            dependencies: [
                "Auth0Client",
                "Models",
                "UserDefaultsClient",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "NukeUI", package: "Nuke"),
            ],
            plugins: []
        ),
        .target(
            name: "Auth0Client",
            dependencies: [
                .product(name: "Auth0", package: "Auth0.swift"),
                .product(name: "Dependencies", package: "swift-dependencies"),
            ],
            resources: [
                .process("./Auth0.plist"),
            ]
        ),
        .target(
            name: "KantackyPackage",
            dependencies: [
                "Account",
                "SignIn",
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
            ],
            plugins: []
        ),
        .testTarget(
            name: "KantackyPackageTests",
            dependencies: ["KantackyPackage"]
        ),
        .target(
            name: "Models",
            dependencies: [
                .product(name: "Auth0", package: "Auth0.swift"),
            ],
            plugins: []
        ),
        .target(
            name: "SignIn",
            dependencies: [
                "Auth0Client",
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
