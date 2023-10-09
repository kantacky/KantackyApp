import Account
import ComposableArchitecture

struct MainReducer: Reducer {
    // MARK: - State
    struct State: Equatable {
        var account: AccountReducer.State

        init() {
            self.account = .init(user: .example0)
        }
    }

    // MARK: - Action
    enum Action: Equatable {
        case account(AccountReducer.Action)
    }

    // MARK: - Dependencies

    init() {}

    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Scope(state: \.account, action: /Action.account) {
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
