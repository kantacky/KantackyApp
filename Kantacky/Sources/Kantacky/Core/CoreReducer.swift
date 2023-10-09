import ComposableArchitecture
import SignIn

struct CoreReducer: Reducer {
    // MARK: - State
    enum State: Equatable {
        case signIn(SignInReducer.State)
        case main(MainReducer.State)

        init() {
            self = .signIn(.init())
        }
    }

    // MARK: - Action
    enum Action: Equatable {
        case signIn(SignInReducer.Action)
        case main(MainReducer.Action)
    }

    // MARK: - Dependencies

    init() {}

    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .signIn(.onSignInButtonTapped):
                state = .main(.init())
                return .none

            case .main(.account(.onSignOutButtonTapped)):
                state = .signIn(.init())
                return .none

            case .signIn:
                return .none

            case .main:
                return .none
            }
        }
        .ifCaseLet(/State.signIn, action: /Action.signIn) {
            SignInReducer()
        }
        .ifCaseLet(/State.main, action: /Action.main) {
            MainReducer()
        }
    }
}
