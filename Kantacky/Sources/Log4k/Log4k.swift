import ComposableArchitecture
import Data
import Foundation
import SwiftData
import SwiftDataClient

@Reducer
public struct Log4k {
    // MARK: - State
    public struct State: Equatable {
        var items: [Log4kItem]

        public init() {
            self.items = []
        }
    }

    // MARK: - Action
    public enum Action {
        case onAppear
        case reload
        case fetchAllLog4kItemsResult(Result<[Log4kItem], Error>)
        case queryChanged([Log4kItem])
    }

    // MARK: - Dependencies
    @Dependency(Log4kClient.self) private var log4kClient

    public init() {}

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                let item = Log4kItem(
                    id: UUID(),
                    date: Date(),
                    evaluation: Log4kEvaluation(happy: 0, satisfied: 0, exauhsted: 0),
                    events: []
                )
                do {
                    try log4kClient.add(item)
                } catch {
                    debugPrint(error.localizedDescription)
                }
                return .none

            case .reload:
                return .run { send in
                    await send(.fetchAllLog4kItemsResult(Result {
                        try log4kClient.fetchAll()
                    }))
                }

            case .fetchAllLog4kItemsResult(.success(let items)):
                state.items = items
                return .none

            case .fetchAllLog4kItemsResult(.failure(let error)):
                debugPrint(error.localizedDescription)
                return .none

            case .queryChanged(let items):
                state.items = items
                return .none
            }
        }
    }
}
