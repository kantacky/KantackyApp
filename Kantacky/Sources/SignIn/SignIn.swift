import Auth0
import Auth0Client
import ComposableArchitecture
import KantackyEntity
import JWTDecode

@Reducer
public struct SignIn {
    // MARK: - State
    @ObservableState
    public struct State {
        @Presents var alert: AlertState<Action.Alert>?

        public init() {}
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case alert(PresentationAction<Alert>)
        case binding(BindingAction<State>)
        case onAppear
        case continueButtonTapped
        case signIn(Result<User, Error>)

        public enum Alert {}
    }

    // MARK: - Dependencies
    @Dependency (Auth0Client.self) private var auth0Client: Auth0Client

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

            case .onAppear:
                return .none

            case .continueButtonTapped:
                return .run { send in
                    await send(.signIn(Result {
                        let credentials = try await self.auth0Client.signIn()
                        return try User.from(credentials)
                    }))
                }

            case .signIn(.success(_)):
                return .none

            case .signIn(.failure(_)):
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
