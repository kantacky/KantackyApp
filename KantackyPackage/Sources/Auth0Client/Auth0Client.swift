import Auth0
import Dependencies
import DependenciesMacros

@DependencyClient
public struct Auth0Client: Sendable {
    public var signIn: @Sendable () async throws -> Credentials
    public var signOut: @Sendable () async throws -> Void
    public var getCredentials: @Sendable () async throws -> Credentials
    public var renewCredentials: @Sendable () async throws -> Credentials
}


extension Auth0Client: DependencyKey {
    public static let liveValue = Auth0Client(
        signIn: { try await Implementation.signIn() },
        signOut: { try await Implementation.signOut() },
        getCredentials: { try await Implementation.getCredentials() },
        renewCredentials: { try await Implementation.renewCredentials() }
    )
}

extension Auth0Client: TestDependencyKey {
    public static let testValue = Auth0Client()
    public static let previewValue = Auth0Client()
}
