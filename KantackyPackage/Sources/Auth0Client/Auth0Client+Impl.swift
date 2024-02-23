import Auth0
import Dependencies
import Foundation

extension Auth0Client: DependencyKey {
    public static let liveValue: Self = .init(
        signIn: {
            try await signIn()
        },
        signOut: {
            try await signOut()
        },
        getCredentials: {
            try await getCredentials()
        },
        renewCredentials: {
            try await renewCredentials()
        }
    )

    private static let path: String = Bundle.module.path(forResource: "Auth0", ofType: "plist")!
    private static let configurations = NSDictionary(contentsOfFile: path)!
    private static let clientId = configurations.value(forKey: "ClientId") as! String
    private static let domain = configurations.value(forKey: "Domain") as! String

    private static func signIn() async throws -> Credentials {
        // Start Web Session
        let credentials = try await Auth0.webAuth(clientId: clientId, domain: domain)
            .scope("openid profile email offline_access")
            .start()

        let authentication = Auth0.authentication(clientId: clientId, domain: domain)
        let credentialsManager = Auth0.CredentialsManager(authentication: authentication)

        if !credentialsManager.store(credentials: credentials) {
            throw CredentialsManagerError.storeFailed
        }

        return credentials
    }

    private static func signOut() async throws {
        // Clear Web Session
        try await Auth0.webAuth(clientId: clientId, domain: domain).clearSession()

        let authentication = Auth0.authentication(clientId: clientId, domain: domain)
        let credentialsManager = Auth0.CredentialsManager(authentication: authentication)

        if !credentialsManager.clear() {
            throw CredentialsManagerError.revokeFailed
        }
    }

    private static func getCredentials() async throws -> Credentials {
        let authentication = Auth0.authentication(clientId: clientId, domain: domain)
        let credentialsManager = Auth0.CredentialsManager(authentication: authentication)

        guard credentialsManager.canRenew() else {
            throw CredentialsManagerError.noCredentials
        }

        return try await credentialsManager.credentials()
    }

    private static func renewCredentials() async throws -> Credentials {
        let authentication = Auth0.authentication(clientId: clientId, domain: domain)
        let credentialsManager = Auth0.CredentialsManager(authentication: authentication)

        let credentials = try await credentialsManager.renew()

        if !credentialsManager.store(credentials: credentials) {
            throw CredentialsManagerError.storeFailed
        }

        return credentials
    }
}
