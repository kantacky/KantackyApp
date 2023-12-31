import Auth0
import Foundation

public struct Auth0Client {
    public var signIn: @Sendable () async throws -> Credentials
    public var signOut: @Sendable () async throws -> Void
    public var getCredentials: @Sendable () async throws -> Credentials
    public var renewCredentials: @Sendable () async throws -> Credentials

    public init(
        signIn: @Sendable @escaping () async throws -> Credentials,
        signOut: @Sendable @escaping () async throws -> Void,
        getCredentials: @Sendable @escaping () async throws -> Credentials,
        renewCredentials: @Sendable @escaping () async throws -> Credentials
    ) {
        self.signIn = signIn
        self.signOut = signOut
        self.getCredentials = getCredentials
        self.renewCredentials = renewCredentials
    }
}
