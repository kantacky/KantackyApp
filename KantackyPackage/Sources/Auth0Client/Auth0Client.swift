import Auth0
import DependenciesMacros

@DependencyClient
public struct Auth0Client: Sendable {
    public var signIn: @Sendable () async throws -> Credentials
    public var signOut: @Sendable () async throws -> Void
    public var getCredentials: @Sendable () async throws -> Credentials
    public var renewCredentials: @Sendable () async throws -> Credentials
}
