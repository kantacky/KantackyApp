import ComposableArchitecture

public struct SignInReducer: Reducer {
    // MARK: - State
    public struct State: Equatable {
        var username: String
        var password: String

        public init() {
            self.username = ""
            self.password = ""
        }
    }

    // MARK: - Action
    public enum Action: Equatable {
        case onUsernameChanged(String)
        case onPasswordChanged(String)
        case onSignInButtonTapped
    }

    // MARK: - Dependencies

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .onUsernameChanged(newValue):
                state.username = newValue
                return .none

            case let .onPasswordChanged(newValue):
                state.password = newValue
                return .none

            case .onSignInButtonTapped:
                return .none
            }
        }
    }
}
