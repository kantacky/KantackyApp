import Auth0
import Auth0Client
import ComposableArchitecture
import Data
import SignIn

@Reducer
struct Root {
    // MARK: - State
    @ObservableState
    enum State: Equatable {
        case launch
        case signIn(SignIn.State)
        case core(Core.State)

        init() {
            self = .launch
        }
    }

    // MARK: - Action
    enum Action {
        case onAppear
        case getCredentialsResult(TaskResult<Credentials>)
        case signIn(SignIn.Action)
        case core(Core.Action)
    }

    // MARK: - Dependencies
    @Dependency(Auth0Client.self) private var auth0Client: Auth0Client

    // MARK: - Reducer
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    await send(.getCredentialsResult(TaskResult {
                        try await self.auth0Client.getCredentials()
                    }))
                }

            case .getCredentialsResult(.success(let credentials)):
                do {
                    let user = try User.from(credentials)
                    state = .core(.init(user: user))
                } catch {
                    state = .signIn(.init())
                    return .none
                }
                return .none

            case .getCredentialsResult(.failure(_)):
                state = .signIn(.init())

                return .none

            case .core(.account(.signOutResult(.success(_)))):
                state = .signIn(.init())
                return .none

            case .signIn:
                return .none

            case .core:
                return .none
            }
        }
    }
}
