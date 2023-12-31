import Auth0
import Auth0Client
import ComposableArchitecture
import JWTDecode

@Reducer
public struct SignInReducer {
    // MARK: - State
    public struct State: Equatable {
        @BindingState var username: String
        @BindingState var password: String
        var isPasswordFieldShown: Bool
        var isLoading: Bool

        private var isValidUsername: Bool { !self.username.isEmpty }
        private var isValidPassword: Bool { !self.password.isEmpty }

        var isDisabledContinueButton: Bool { !self.isValidUsername }
        var isDisabledSignInButton: Bool { !self.isValidUsername || !self.isValidPassword }

        public init() {
            self.username = ""
            self.password = ""
            self.isPasswordFieldShown = false
            self.isLoading = false
        }
    }

    enum Field {
        case username, password
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onContinueButtonTapped
        case onSignInButtonTapped
        case authResult(TaskResult<Credentials>)
    }

    // MARK: - Dependencies
    @Dependency (\.auth0Client)
    private var auth0Client: Auth0Client

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .onContinueButtonTapped:
                return .run { send in
                    await send(.authResult(TaskResult {
                        try await self.auth0Client.signIn()
                    }))
                }

            case .onSignInButtonTapped:
                return .none

            case .authResult(.success(_)):
                return .none

            case .authResult(.failure(_)):
                return .none
            }
        }

        BindingReducer()
    }
}
