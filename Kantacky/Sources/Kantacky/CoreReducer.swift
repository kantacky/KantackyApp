import ComposableArchitecture
import SignIn

public struct CoreReducer: Reducer {
    // MARK: - State
    public enum State: Equatable {
        case signIn(SignInReducer.State)
        case main(MainState)

        public init() {
            self = .signIn(.init())
        }
    }

    public struct MainState: Equatable {
        public init() {}
    }

    // MARK: - Action
    public enum Action: Equatable {
        case signIn(SignInReducer.Action)
        case main(MainAction)
    }

    public enum MainAction: Equatable {}

    // MARK: - Dependencies

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .signIn:
                return .none

            case .main:
                return .none
            }
        }
        .ifCaseLet(/State.signIn, action: /Action.signIn) {
            SignInReducer()
        }
    }
}
