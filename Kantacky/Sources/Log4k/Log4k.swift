import ComposableArchitecture
import Data
import Foundation
import SwiftData
import SwiftDataClient

@Reducer
public struct Log4k {
    @Reducer
    public enum Destination {
        case add(Add)
        case detail(Detail)
        case edit(Edit)
    }

    // MARK: - State
    @ObservableState
    public struct State {
        @Presents var alert: AlertState<Action.Alert>?
        @Presents var destination: Destination.State?
        var items: IdentifiedArrayOf<Log4kItem> = []

        public init() {
            self.items = []
        }
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case alert(PresentationAction<Alert>)
        case destination(PresentationAction<Destination.Action>)
        case plusButtonTapped
        case queryChanged([Log4kItem])

        public enum Alert {}
    }

    // MARK: - Dependencies
    @Dependency(SwiftDataClient.self) private var swiftDataClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .alert:
                return .none

            case .destination:
                return .none

            case .plusButtonTapped:
                state.destination = .add(Add.State())
                return .none

            case .queryChanged(let items):
                state.items = IdentifiedArrayOf(uniqueElements: items)
                return .none
            }
        }
        .ifLet(\.$alert, action: \.alert)
        .ifLet(\.$destination, action: \.destination)
    }
}
