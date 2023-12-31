import Dependencies

public extension DependencyValues {
    var auth0Client: Auth0Client {
        get { self[Auth0Client.self] }
        set { self[Auth0Client.self] = newValue }
    }
}
