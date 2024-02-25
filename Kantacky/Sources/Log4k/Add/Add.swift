import ComposableArchitecture
import Data
import Dependencies
import SwiftDataClient

@Reducer
public struct Add {
    // MARK: - State
    @ObservableState
    public struct State {
        var item: Log4kItem = Log4kItem(
            date: .today,
            happy: 5,
            satisfied: 5,
            exhausted: 5,
            events: []
        )
        
        public init() {}
    }
    
    // MARK: - Action
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case cancelButtonTapped
        case saveButtonTapped
    }
    
    // MARK: - Dependencies
    @Dependency(\.dismiss) private var dismiss
    @Dependency(SwiftDataClient.self) private var swiftDataClient

    public init() {}
    
    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .binding:
                return .none
                
            case .cancelButtonTapped:
                return .run { _ in
                    await dismiss()
                }
                
            case .saveButtonTapped:
                return .run { [item = state.item] _ in
                    Task { @MainActor in
                        swiftDataClient.container.mainContext.insert(item)
                        await dismiss()
                    }
                }
            }
        }
    }
}
