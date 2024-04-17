import Auth0
import Foundation
import JWTDecode

public struct User: Identifiable {
    public var id: String
    public var name: String
    public var email: String
    public var isEmailVerified: Bool
    public var avator: URL

    public init(
        id: String,
        name: String,
        email: String,
        isEmailVerified: Bool,
        avator: URL
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.isEmailVerified = isEmailVerified
        self.avator = avator
    }
}

public extension User {
    static func from(_ credentials: Credentials) throws -> Self {
        guard let jwt = try? decode(jwt: credentials.idToken),
              let id = jwt["sub"].string,
              let name = jwt["name"].string,
              let email = jwt["email"].string,
              let isEmailVerified = jwt["email_verified"].boolean,
              let picture = jwt["picture"].string
        else {
            throw JWTDecodeError.invalidJSON("")
        }

        return .init(
            id: id,
            name: name,
            email: email,
            isEmailVerified: isEmailVerified,
            avator: .init(string: picture)!
        )
    }
}

public extension User {
    static let example0: Self = .init(
        id: UUID().uuidString,
        name: "John Due",
        email: "john@example.com",
        isEmailVerified: true,
        avator: .init(string: "https://s.gravatar.com/avatar/77fbd83c506bf1d9de31bbb843d64e53?s=480&r=pg&d=https%3A%2F%2Fcdn.auth0.com%2Favatars%2Fj.png")!
    )
}
