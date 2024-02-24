import ComposableArchitecture
import Core
import Data
import Launch
import SignIn

@Reducer
public struct Root {
    @Reducer
    public enum Scene {
        case launch(Launch)
        case signIn(SignIn)
        case core(Core)
    }

    // MARK: - State
    @ObservableState
    public struct State {
        var scene: Scene.State = .launch(Launch.State())

        public init() {}
    }

    // MARK: - Action
    public enum Action {
        case scene(Scene.Action)
    }

    // MARK: - Dependencies

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Scope(state: \.scene, action: \.scene) {
            Scene.body
        }

        Reduce { state, action in
            switch action {
            case let .scene(.launch(.validateUser(.success(user)))):
                state.scene = .core(Core.State(user: user))
                return .none

            case .scene(.launch(.validateUser(.failure(_)))):
                state.scene = .signIn(SignIn.State())
                return .none

            case let .scene(.signIn(.signIn(.success(user)))):
                state.scene = .core(Core.State(user: user))
                return .none

            case .scene(.core(.account(.signOut(.success)))):
                state.scene = .signIn(SignIn.State())
                return .none

            case .scene:
                return .none
            }
        }
    }
}
