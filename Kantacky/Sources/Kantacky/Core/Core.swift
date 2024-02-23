import Account
import Chat
import ComposableArchitecture
import Data
import Log4k

@Reducer
struct Core {
    // MARK: - State
    @ObservableState
    struct State: Equatable {
        var account: Account.State
        var chat: Chat.State
        var log4k: Log4k.State

        init(user: User) {
            self.account = .init(user: user)
            self.chat = .init()
            self.log4k = .init()
        }
    }

    // MARK: - Action
    enum Action {
        case account(Account.Action)
        case chat(Chat.Action)
        case log4k(Log4k.Action)
    }

    // MARK: - Dependencies

    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Scope(state: \.account, action: \.account) {
            Account()
        }
        Scope(state: \.log4k, action: \.log4k) {
            Log4k()
        }
        Scope(state: \.chat, action: \.chat) {
            Chat()
        }
        Reduce { state, action in
            switch action {
            case .account:
                return .none

            case .chat:
                return .none

            case .log4k:
                return .none
            }
        }
    }
}
