import ComposableArchitecture

public struct SignInReducer: Reducer {
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
    public enum Action: Equatable, BindableAction {
        case binding(BindingAction<State>)
        case onContinueButtonTapped
        case onSignInButtonTapped
    }

    // MARK: - Dependencies

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .onContinueButtonTapped:
                state.isPasswordFieldShown = true
                return .none

            case .onSignInButtonTapped:
                return .none
            }
        }

        BindingReducer()
    }
}
