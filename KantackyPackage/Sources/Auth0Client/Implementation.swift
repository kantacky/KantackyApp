import Auth0
import Foundation

enum Implementation {
    static func signIn() async throws -> Credentials {
        let path: String = Bundle.module.path(forResource: "Auth0", ofType: "plist")!
        let configurations: NSDictionary = .init(contentsOfFile: path)!
        let clientId: String = configurations.value(forKey: "ClientId") as! String
        let domain: String = configurations.value(forKey: "Domain") as! String

        let credentials: Credentials = try await Auth0.webAuth(clientId: clientId, domain: domain)
            .scope("openid profile email offline_access")
            .start()

        let authentication: Authentication = Auth0.authentication(clientId: clientId, domain: domain)
        let credentialsManager: CredentialsManager = Auth0.CredentialsManager(authentication: authentication)

        if !credentialsManager.store(credentials: credentials) {
            throw CredentialsManagerError.storeFailed
        }

        return credentials
    }

    static func signOut() async throws {
        let path: String = Bundle.module.path(forResource: "Auth0", ofType: "plist")!
        let configurations: NSDictionary = .init(contentsOfFile: path)!
        let clientId: String = configurations.value(forKey: "ClientId") as! String
        let domain: String = configurations.value(forKey: "Domain") as! String

//        try await Auth0.webAuth(clientId: clientId, domain: domain).clearSession()

        let authentication: Authentication = Auth0.authentication(clientId: clientId, domain: domain)
        let credentialsManager: CredentialsManager = Auth0.CredentialsManager(authentication: authentication)

        if !credentialsManager.clear() {
            throw CredentialsManagerError.revokeFailed
        }
    }

    static func getCredentials() async throws -> Credentials {
        let path: String = Bundle.module.path(forResource: "Auth0", ofType: "plist")!
        let configurations: NSDictionary = .init(contentsOfFile: path)!
        let clientId: String = configurations.value(forKey: "ClientId") as! String
        let domain: String = configurations.value(forKey: "Domain") as! String

        let authentication: Authentication = Auth0.authentication(clientId: clientId, domain: domain)
        let credentialsManager: CredentialsManager = Auth0.CredentialsManager(authentication: authentication)

        guard credentialsManager.canRenew() else {
            throw CredentialsManagerError.noCredentials
        }

        let credentials: Credentials = try await credentialsManager.credentials()

        return credentials
    }

    static func renewCredentials() async throws -> Credentials {
        let path: String = Bundle.module.path(forResource: "Auth0", ofType: "plist")!
        let configurations: NSDictionary = .init(contentsOfFile: path)!
        let clientId: String = configurations.value(forKey: "ClientId") as! String
        let domain: String = configurations.value(forKey: "Domain") as! String

        let authentication: Authentication = Auth0.authentication(clientId: clientId, domain: domain)
        let credentialsManager: CredentialsManager = Auth0.CredentialsManager(authentication: authentication)

        let credentials: Credentials = try await credentialsManager.renew()

        if !credentialsManager.store(credentials: credentials) {
            throw CredentialsManagerError.storeFailed
        }

        return credentials
    }
}
