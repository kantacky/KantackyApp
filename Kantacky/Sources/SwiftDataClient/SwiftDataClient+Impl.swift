import Data
import Dependencies
import Foundation
import SwiftData

extension SwiftDataClient: DependencyKey {
    public static let liveValue: Self = .init(
        container: {
            let schema = Schema([Log4kItem.self])
            let config = ModelConfiguration(
                schema: schema
            )
            do {
                return try ModelContainer(for: schema, configurations: [config])
            } catch {
                fatalError(error.localizedDescription)
            }
        }()
    )
}

extension SwiftDataClient: TestDependencyKey {
    public static let testValue: Self = .init(
        container: {
            let schema = Schema([Log4kItem.self])
            let config = ModelConfiguration(
                schema: schema,
                isStoredInMemoryOnly: true
            )
            do {
                let container = try ModelContainer(for: schema, configurations: [config])
                Task { @MainActor in
                    container.mainContext.insert(Log4kItem(date: .today, happy: 3, satisfied: 4, exhausted: 2, events: []))
                    container.mainContext.insert(Log4kItem(date: .today, happy: 3, satisfied: 2, exhausted: 4, events: []))
                }
                return container
            } catch {
                fatalError(error.localizedDescription)
            }
        }()
    )

    public static let previewValue: Self = .testValue
}
