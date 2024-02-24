import ComposableArchitecture
import Data

@Reducer
public struct Detail {
    // MARK: - State
    @ObservableState
    public struct State {
        var item: Log4kItem

        public init(item: Log4kItem) {
            self.item = item
        }
    }

    // MARK: - Action
    public enum Action {
        case editButtonTapped
    }

    // MARK: - Dependencies

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .editButtonTapped:
                return .none
            }
        }
    }
}
