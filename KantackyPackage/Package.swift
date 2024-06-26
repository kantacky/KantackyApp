// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "KantackyPackage",
    defaultLocalization: "en",
    platforms: [.iOS(.v18)],
    products: [
        .library(name: "Account", targets: ["Account"]),
        .library(name: "Core", targets: ["Core"]),
        .library(name: "KantackyPackage", targets: ["KantackyPackage"]),
        .library(name: "Launch", targets: ["Launch"]),
        .library(name: "Root", targets: ["Root"]),
        .library(name: "SignIn", targets: ["SignIn"]),
    ],
    dependencies: [
        .package(url: "https://github.com/auth0/Auth0.swift", .upToNextMajor(from: "2.0.0")),
        .package(url: "https://github.com/kean/Nuke", .upToNextMajor(from: "12.0.0")),
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/pointfreeco/swift-dependencies", .upToNextMajor(from: "1.0.0")),
        .package(url: "https://github.com/swiftlang/swift-format", .upToNextMajor(from: "510.0.0")),
    ],
    targets: [
        .target(
            name: "Account",
            dependencies: [
                .auth0Client,
                .composableArchitecture,
                .kantackyEntity,
                .nukeUI,
                .resources,
            ]
        ),
        .target(
            name: "Auth0Client",
            dependencies: [
                .auth0,
                .dependencies,
                .dependenciesMacros,
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
                .kantackyEntity,
            ]
        ),
        .target(
            name: "KantackyPackage",
            dependencies: [
                .composableArchitecture,
                .root,
            ]
        ),
        .target(
            name: "KantackyEntity",
            dependencies: [
                .auth0,
            ]
        ),
        .target(
            name: "Launch",
            dependencies: [
                .auth0,
                .auth0Client,
                .composableArchitecture,
                .kantackyEntity,
                .resources,
            ]
        ),
        .target(name: "Resources"),
        .target(
            name: "Root",
            dependencies: [
                .composableArchitecture,
                .core,
                .kantackyEntity,
                .launch,
                .signIn
            ]
        ),
        .target(
            name: "SignIn",
            dependencies: [
                .auth0Client,
                .composableArchitecture,
                .kantackyEntity,
                .resources,
            ]
        ),
    ]
)

extension Target.Dependency {
    static let account: Self = "Account"
    static let auth0Client: Self = "Auth0Client"
    static let core: Self = "Core"
    static let kantackyEntity: Self = "KantackyEntity"
    static let launch: Self = "Launch"
    static let resources: Self = "Resources"
    static let root: Self = "Root"
    static let signIn: Self = "SignIn"

    static let auth0: Self = .product(name: "Auth0", package: "Auth0.swift")
    static let composableArchitecture: Self = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
    static let dependencies: Self = .product(name: "Dependencies", package: "swift-dependencies")
    static let dependenciesMacros: Self = .product(name: "DependenciesMacros", package: "swift-dependencies")
    static let nukeUI: Self = .product(name: "NukeUI", package: "Nuke")
}
