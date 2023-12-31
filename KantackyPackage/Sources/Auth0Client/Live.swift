import Auth0
import Dependencies
import Foundation

extension Auth0Client: DependencyKey {
    public static let liveValue: Self = .init(
        signIn: {
            try await Implementation.signIn()
        },
        signOut: {
            try await Implementation.signOut()
        },
        getCredentials: {
            try await Implementation.getCredentials()
        },
        renewCredentials: {
            try await Implementation.renewCredentials()
        }
    )
}
