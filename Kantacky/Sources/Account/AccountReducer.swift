import ComposableArchitecture
import Dependencies
import Models
import UserDefaultsClient

public struct AccountReducer: Reducer {
    // MARK: - State
    public struct State: Equatable {
        var user: User

        public init(user: User) {
            self.user = user
        }
    }

    // MARK: - Action
    public enum Action: Equatable {
        case onUsernameChanged(String)
        case onFirstnameChanged(String)
        case onMiddlenameChanged(String)
        case onLastnameChanged(String)
        case onEmailChanged(String)
        case onUsePasskeyButtonTapped
        case onSignOutButtonTapped
    }

    // MARK: - Dependencies
    @Dependency(\.userDefaultsClient)
    private var userDefaultsClient: UserDefaultsClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .onUsernameChanged(newValue):
                state.user.username = newValue
                return .none

            case let .onFirstnameChanged(newValue):
                state.user.firstname = newValue
                return .none

            case let .onMiddlenameChanged(newValue):
                state.user.middlename = newValue
                return .none

            case let .onLastnameChanged(newValue):
                state.user.lastname = newValue
                return .none

            case let .onEmailChanged(newValue):
                state.user.email = newValue
                return .none

            case .onUsePasskeyButtonTapped:
                return .none

            case .onSignOutButtonTapped:
                return .none
            }
        }
    }
}
