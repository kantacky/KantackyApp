import Auth0Client
import ComposableArchitecture
import KantackyEntity

@Reducer
public struct Account {
    // MARK: - State
    @ObservableState
    public struct State {
        @Presents var alert: AlertState<Action.Alert>?
        var user: User

        public init(user: User) {
            self.user = user
        }
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case alert(PresentationAction<Alert>)
        case binding(BindingAction<State>)
        case signOutButtonTapped
        case signOut(Result<Void, Error>)

        public enum Alert {}
    }

    // MARK: - Dependencies
    @Dependency(Auth0Client.self) private var auth0Client

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .alert:
                return .none

            case .binding:
                return .none

            case .signOutButtonTapped:
                return .run { send in
                    await send(
                        .signOut(
                            Result {
                                try await self.auth0Client.signOut()
                            }
                        )
                    )
                }

            case .signOut(.success):
                return .none

            case .signOut(.failure(let error)):
                state.alert = AlertState(
                    title: TextState("Something Went Wrong while Signing Out."),
                    message: TextState(error.localizedDescription)
                )
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
