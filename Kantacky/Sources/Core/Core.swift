import Account
import ComposableArchitecture
import Dependencies
import Data
import Log4k
import SwiftData
import SwiftDataClient

@Reducer
public struct Core {
    // MARK: - State
    @ObservableState
    public struct State {
        var account: Account.State
        var log4k: Log4k.State

        public init(user: User) {
            self.account = .init(user: user)
            self.log4k = .init()
        }
    }

    // MARK: - Action
    public enum Action {
        case account(Account.Action)
        case log4k(Log4k.Action)
    }

    // MARK: - Dependencies

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Scope(state: \.account, action: \.account) {
            Account()
        }
        Scope(state: \.log4k, action: \.log4k) {
            Log4k()
        }

        Reduce { state, action in
            switch action {
            case .account:
                return .none

            case .log4k:
                return .none
            }
        }
    }
}
