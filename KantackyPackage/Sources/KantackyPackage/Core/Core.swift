import Account
import ComposableArchitecture
import Models

@Reducer
struct Core {
    // MARK: - State
    struct State: Equatable {
        var account: AccountReducer.State

        init(user: User) {
            self.account = .init(user: user)
        }
    }

    // MARK: - Action
    enum Action {
        case account(AccountReducer.Action)
    }

    // MARK: - Dependencies

    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Scope(state: \.account, action: \.account) {
            AccountReducer()
        }

        Reduce { state, action in
            switch action {
            case .account:
                return .none
            }
        }
    }
}
