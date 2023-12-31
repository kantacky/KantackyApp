import Auth0Client
import ComposableArchitecture
import Dependencies
import Models
import UserDefaultsClient

@Reducer
public struct AccountReducer {
    // MARK: - State
    public struct State: Equatable {
        @BindingState var user: User

        public init(user: User) {
            self.user = user
        }
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onPullToRefresh
        case onNameChanged
        case onEmailChanged
        case onSignOutButtonTapped
        case signOutResult(TaskResult<Void>)
    }

    // MARK: - Dependencies
    @Dependency(\.auth0Client)
    private var auth0Client: Auth0Client

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .onPullToRefresh:
                return .none

            case .onNameChanged:
                return .none

            case .onEmailChanged:
                return .none

            case .onSignOutButtonTapped:
                return .run { send in
                    await send(.signOutResult(TaskResult {
                        try await self.auth0Client.signOut()
                    }))
                }

            case .signOutResult(.success):
                return .none

            case .signOutResult(.failure(_)):
                return .none
            }
        }

        BindingReducer()
    }
}
