import ComposableArchitecture
import Data
import Dependencies
import SwiftDataClient

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
        case onDisappear
    }

    // MARK: - Dependencies
    @Dependency(\.dismiss) private var dismiss
    @Dependency(SwiftDataClient.self) private var swiftDataClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .cancelButtonTapped:
                return .run { send in
                    await send(.onDisappear)
                    await dismiss()
                }

            case .saveButtonTapped:
                return .run { [item = state.item] send in
                    await send(.onDisappear)
                    Task { @MainActor in
                        swiftDataClient.container.mainContext.insert(item)
                        await dismiss()
                    }
                }

            case .onDisappear:
                return .none
            }
        }
    }
}
