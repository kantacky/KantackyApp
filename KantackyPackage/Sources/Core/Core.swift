import Account
import ComposableArchitecture
import KantackyEntity

@Reducer
public struct Core {
    // MARK: - State
    @ObservableState
    public struct State {
        var account: Account.State

        public init(user: User) {
            self.account = .init(user: user)
        }
    }

    // MARK: - Action
    public enum Action {
        case account(Account.Action)
    }

    // MARK: - Dependencies

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Scope(state: \.account, action: \.account) {
            Account()
        }

        Reduce { state, action in
            switch action {
            case .account:
                return .none
            }
        }
    }
}
