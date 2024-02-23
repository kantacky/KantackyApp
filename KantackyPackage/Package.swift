// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "KantackyPackage",
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
        .library(name: "Chat", targets: ["Chat"]),
        .library(name: "KantackyPackage", targets: ["KantackyPackage"]),
        .library(name: "Log4k", targets: ["Log4k"]),
        .library(name: "SignIn", targets: ["SignIn"]),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies.git", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/auth0/Auth0.swift.git", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/kean/Nuke.git", .upToNextMajor(from: "12.0.0")),
        .package(url: "https://github.com/google/generative-ai-swift.git", .upToNextMajor(from: "0.1.0")),
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
            name: "Chat",
            dependencies: [
                .resources,
                .composableArchitecture,
                .dependencies,
                .generativeAIClient,
                .generativeAI
            ]
        ),
        .target(
            name: "Data",
            dependencies: [
                .auth0,
            ]
        ),
        .target(
            name: "GenerativeAIClient",
            dependencies: [
                .dependencies,
                .generativeAI,
            ],
            resources: [
                .process("./GenerativeAI-Info.plist"),
            ]
        ),
        .target(
            name: "KantackyPackage",
            dependencies: [
                .account,
                .chat,
                .log4k,
                .signIn,
                .swiftDataClient,
                .composableArchitecture,
            ]
        ),
        .testTarget(
            name: "KantackyPackageTests",
            dependencies: [.kantackyPackage]
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
        .target(name: "Resources"),
        .target(
            name: "SignIn",
            dependencies: [
                .auth0Client,
                .resources,
                .composableArchitecture,
                .dependencies,
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
    static let chat: Self = "Chat"
    static let data: Self = "Data"
    static let generativeAIClient: Self = "GenerativeAIClient"
    static let kantackyPackage: Self = "KantackyPackage"
    static let log4k: Self = "Log4k"
    static let resources: Self = "Resources"
    static let signIn: Self = "SignIn"
    static let swiftDataClient: Self = "SwiftDataClient"
    static let userDefaultsClient: Self = "UserDefaultsClient"

    static let auth0: Self = .product(name: "Auth0", package: "Auth0.swift")
    static let composableArchitecture: Self = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    static let dependencies: Self = .product(name: "Dependencies", package: "swift-dependencies")
    static let nukeUI: Self = .product(name: "NukeUI", package: "Nuke")
    static let generativeAI: Self = .product(name: "GoogleGenerativeAI", package: "generative-ai-swift")
}
