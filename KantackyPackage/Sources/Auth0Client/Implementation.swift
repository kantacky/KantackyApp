//
//  File.swift
//  
//
//  Created by Kanta Oikawa on 6/26/24.
//

import Auth0
import Foundation

enum Implementation {
    static func signIn() async throws -> Credentials {
        let credentials = try await Auth0
            .webAuth(clientId: Auth0Utils.clientId, domain: Auth0Utils.domain)
            .useHTTPS()
            .scope(Scope.scopes)
            .start()

        guard
            Auth0Utils.credentialsManager.store(credentials: credentials),
            Auth0Utils.credentialsManager.canRenew()
        else {
            throw CredentialsManagerError.storeFailed
        }

        return credentials
    }

    static func signOut() async throws {
        try await Auth0
            .webAuth(clientId: Auth0Utils.clientId, domain: Auth0Utils.domain)
            .useHTTPS()
            .clearSession()

        guard Auth0Utils.credentialsManager.clear() else {
            throw CredentialsManagerError.revokeFailed
        }
    }

    static func getCredentials() async throws -> Credentials {
        guard Auth0Utils.credentialsManager.canRenew() else {
            return try await signIn()
        }

        return try await renewCredentials()
    }

    static func renewCredentials() async throws -> Credentials {
        return try await Auth0Utils.credentialsManager.renew()
    }
}
