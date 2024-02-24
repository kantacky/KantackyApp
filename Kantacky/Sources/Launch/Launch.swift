import Auth0
import Auth0Client
import ComposableArchitecture
import Data

@Reducer
public struct Launch {
    // MARK: - State
    @ObservableState
    public struct State {
        public init() {}
    }

    // MARK: - Action
    public enum Action {
        case onAppear
        case validateUser(Result<User, Error>)
    }

    // MARK: - Dependencies
    @Dependency(Auth0Client.self) private var auth0Client

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.validateUser(Result {
                        let credentials = try await self.auth0Client.getCredentials()
                        return try User.from(credentials)
                    }))
                }

            case .validateUser(.success(_)):
                return .none

            case .validateUser(.failure(_)):
                return .none
            }
        }
    }
}
