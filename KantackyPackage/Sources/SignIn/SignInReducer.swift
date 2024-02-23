import Auth0
import Auth0Client
import ComposableArchitecture
import JWTDecode

@Reducer
public struct SignInReducer {
    // MARK: - State
    public struct State: Equatable {
        public init() {}
    }

    // MARK: - Action
    public enum Action {
        case onContinueButtonTapped
        case authResult(TaskResult<Credentials>)
    }

    // MARK: - Dependencies
    @Dependency (Auth0Client.self) private var auth0Client: Auth0Client

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onContinueButtonTapped:
                return .run { send in
                    await send(.authResult(TaskResult {
                        try await self.auth0Client.signIn()
                    }))
                }

            case .authResult(.success(_)):
                return .none

            case .authResult(.failure(_)):
                return .none
            }
        }
    }
}
