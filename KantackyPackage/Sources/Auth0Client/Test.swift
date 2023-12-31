import Dependencies

extension Auth0Client: TestDependencyKey {
    public static let testValue: Self = .init(
        signIn: unimplemented(),
        signOut: unimplemented(),
        getCredentials: unimplemented(),
        renewCredentials: unimplemented()
    )

    public static let previewValue = Self.testValue
}
