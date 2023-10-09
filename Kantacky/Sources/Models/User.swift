import Foundation

public struct User: Identifiable, Equatable {
    public let id: UUID
    public var username: String
    public var firstname: String
    public var middlename: String
    public var lastname: String
    public var email: String
    public var authMethod: AuthMethod
    public var passkeys: [String]

    public init(
        id: UUID = .init(),
        username: String = "",
        firstname: String = "",
        middlename: String = "",
        lastname: String = "",
        email: String = "",
        authMethod: AuthMethod,
        passkeys: [String] = []
    ) {
        self.id = id
        self.username = username
        self.firstname = firstname
        self.middlename = middlename
        self.lastname = lastname
        self.email = email
        self.authMethod = authMethod
        self.passkeys = passkeys
    }
}

extension User {
    public var fullname: String {
        var fullname: String = ""

        if !self.firstname.isEmpty {
            fullname += self.firstname
        }

        if !self.middlename.isEmpty {
            if !fullname.isEmpty {
                fullname += " "
            }

            fullname += self.middlename
        }

        if !self.lastname.isEmpty {
            if !fullname.isEmpty {
                fullname += " "
            }

            fullname += self.lastname
        }

        return fullname
    }
}

public enum AuthMethod {
    case password
    case passkey
}

#if DEBUG
extension User {
    public static let example0: Self = .init(
        username: "john",
        firstname: "John",
        lastname: "Due",
        email: "john@kantacky.com",
        authMethod: .passkey,
        passkeys: [
            "Passkey (iOS)",
            "Passkey (Chrome)",
        ]
    )
    public static let example1: Self = .init(
        username: "john",
        firstname: "John",
        lastname: "Due",
        email: "john@kantacky.com",
        authMethod: .password
    )
}
#endif
