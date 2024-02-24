// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "Kantacky",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .watchOS(.v10),
        .tvOS(.v17),
        .visionOS(.v1),
    ],
    products: [
        .library(name: "Account", targets: ["Account"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "Kantacky", targets: ["Kantacky"]),
        .library(name: "Launch", targets: ["Launch"]),
        .library(name: "Log4k", targets: ["Log4k"]),
        .library(name: "Root", targets: ["Root"]),
        .library(name: "SignIn", targets: ["SignIn"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/auth0/Auth0.swift.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/kean/Nuke.git", .upToNextMajor(from: "12.0.0")),
    ],
    targets: [
        .target(
            name: "Account",
            dependencies: [
                .auth0Client,
                .data,
                .resources,
                .composableArchitecture,
                .dependencies,
                .nukeUI,
            ]
        ),
        .testTarget(
            name: "AccountTests",
            dependencies: [
                .account,
                .composableArchitecture,
            ]
        ),
        .target(
            name: "Auth0Client",
            dependencies: [
                .auth0,
                .dependencies,
            ],
            resources: [
                .process("./Auth0.plist"),
            ]
        ),
        .target(
            name: "Core",
            dependencies: [
                .account,
                .composableArchitecture,
                .dependencies,
                .data,
                .log4k,
                .swiftDataClient
            ]
        ),
        .testTarget(
            name: "CoreTests",
            dependencies: [
                .core,
                .composableArchitecture,
            ]
        ),
        .target(
            name: "Data",
            dependencies: [
                .auth0,
            ]
        ),
        .target(
            name: "Kantacky",
            dependencies: [
                .composableArchitecture,
                .root,
            ]
        ),
        .testTarget(
            name: "KantackyTests",
            dependencies: [
                .kantacky,
                .composableArchitecture,
            ]
        ),
        .target(
            name: "Launch",
            dependencies: [
                .auth0Client,
                .data,
                .resources,
                .auth0,
                .composableArchitecture,
            ]
        ),
        .testTarget(
            name: "LaunchTests",
            dependencies: [
                .launch,
                .composableArchitecture,
            ]
        ),
        .target(
            name: "Log4k",
            dependencies: [
                .data,
                .swiftDataClient,
                .composableArchitecture,
                .dependencies,
            ]
        ),
        .testTarget(
            name: "Log4kTests",
            dependencies: [
                .log4k,
                .composableArchitecture,
            ]
        ),
        .target(name: "Resources"),
        .target(
            name: "Root",
            dependencies: [
                .composableArchitecture,
                .core,
                .data,
                .launch,
                .signIn
            ]
        ),
        .testTarget(
            name: "RootTests",
            dependencies: [
                .root,
                .composableArchitecture,
            ]
        ),
        .target(
            name: "SignIn",
            dependencies: [
                .auth0Client,
                .resources,
                .composableArchitecture,
                .dependencies,
            ]
        ),
        .testTarget(
            name: "SignInTests",
            dependencies: [
                .signIn,
                .composableArchitecture,
            ]
        ),
        .target(
            name: "SwiftDataClient",
            dependencies: [
                .data,
                .dependencies,
            ]
        ),
        .target(
            name: "UserDefaultsClient",
            dependencies: [
                .dependencies,
            ]
        )
    ]
)

extension Target.Dependency {
    static let account: Self = "Account"
    static let auth0Client: Self = "Auth0Client"
    static let core: Self = "Core"
    static let data: Self = "Data"
    static let generativeAIClient: Self = "GenerativeAIClient"
    static let kantacky: Self = "Kantacky"
    static let launch: Self = "Launch"
    static let log4k: Self = "Log4k"
    static let resources: Self = "Resources"
    static let root: Self = "Root"
    static let signIn: Self = "SignIn"
    static let swiftDataClient: Self = "SwiftDataClient"
    static let userDefaultsClient: Self = "UserDefaultsClient"

    static let auth0: Self = .product(name: "Auth0", package: "Auth0.swift")
    static let composableArchitecture: Self = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    static let dependencies: Self = .product(name: "Dependencies", package: "swift-dependencies")
    static let nukeUI: Self = .product(name: "NukeUI", package: "Nuke")
}
