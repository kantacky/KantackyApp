import Auth0
import Auth0Client
import ComposableArchitecture
import Models
import SignIn

@Reducer
struct Root {
    // MARK: - State
    struct State: Equatable {
        var scene: Scene
        @PresentationState var alert: AlertState<Action.Alert>?

        init() {
            self.scene = .launch
        }

        @CasePathable
        enum Scene: Equatable {
            case launch
            case signIn(SignInReducer.State)
            case core(Core.State)
        }
    }

    // MARK: - Action
    enum Action {
        case alert(PresentationAction<Alert>)
        case onAppear
        case getCredentialsResult(TaskResult<Credentials>)
        case signIn(SignInReducer.Action)
        case core(Core.Action)

        enum Alert: Equatable {}
    }

    // MARK: - Dependencies
    @Dependency(Auth0Client.self) private var auth0Client: Auth0Client

    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Scope(state: \.scene, action: \.self) {
            Scope(state: \.signIn, action: \.signIn) {
                SignInReducer()
            }
            Scope(state: \.core, action: \.core) {
                Core()
            }
        }

        Reduce { state, action in
            switch action {
            case .alert:
                return .none

            case .onAppear:
                return .run { send in
                    await send(.getCredentialsResult(TaskResult {
                        try await self.auth0Client.getCredentials()
                    }))
                }

            case let .getCredentialsResult(.success(credentials)):
                do {
                    let user: User = try User.from(credentials)
                    state.scene = .core(.init(user: user))
                } catch {
                    state.scene = .signIn(.init())
                    return .none
                }
                return .none

            case .getCredentialsResult(.failure(_)):
                state.scene = .signIn(.init())

                return .none

            case let .signIn(.authResult(.success(credentials))):
                do {
                    let user: User = try User.from(credentials)
                    state.scene = .core(.init(user: user))
                } catch {
                    state.alert = .init(title: { .init(error.localizedDescription) })
                    return .none
                }
                return .none

            case .core(.account(.signOutResult(.success(_)))):
                state.scene = .signIn(.init())
                return .none

            case let .core(.account(.signOutResult(.failure(error)))):
                state.alert = .init(title: { .init(error.localizedDescription) })
                return .none

            case .signIn:
                return .none

            case .core:
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
    }
}
