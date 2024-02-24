import ComposableArchitecture
import Data
import Dependencies

@Reducer
public struct Edit {
    // MARK: - State
    @ObservableState
    public struct State {
        var item: Log4kItem

        public init(item: Log4kItem) {
            self.item = item
        }
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case cancelButtonTapped
        case saveButtonTapped
    }

    // MARK: - Dependencies
    @Dependency(\.dismiss) private var dismiss

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .cancelButtonTapped:
                return .run { _ in
                    await dismiss()
                }

            case .saveButtonTapped:
                return .none
            }
        }
    }
}
