import Data
import Dependencies
import Foundation
import SwiftData

extension SwiftDataClient: DependencyKey {
    public static let liveValue: Self = .init(
        context: {
            let schema = Schema([
                Log4kItem.self,
            ])
            let configuration = ModelConfiguration(schema: schema)
            let container = try ModelContainer(for: schema, configurations: [configuration])
            return ModelContext(container)
        }
    )
}
