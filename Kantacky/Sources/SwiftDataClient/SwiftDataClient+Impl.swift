import Data
import Dependencies
import Foundation
import SwiftData

extension SwiftDataClient: DependencyKey {
    public static let liveValue: Self = .init(
        container: {
            let schema = Schema([
                Log4kItem.self
            ])
            do {
                return try ModelContainer(for: schema)
            } catch {
                fatalError(error.localizedDescription)
            }
        }()
    )
}
