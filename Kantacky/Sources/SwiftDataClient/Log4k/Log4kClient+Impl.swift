import Data
import Dependencies
import Foundation
import SwiftData

extension Log4kClient: DependencyKey {
    public static let liveValue: Self = .init(
        fetchAll: {
            @Dependency(SwiftDataClient.self) var swiftDataClient
            let context = try swiftDataClient.context()
            let descriptor = FetchDescriptor<Log4kItem>(sortBy: [SortDescriptor(\.date)])
            return try context.fetch(descriptor)
        },
        fetch: { descriptor in
            @Dependency(SwiftDataClient.self) var swiftDataClient
            let context = try swiftDataClient.context()
            return try context.fetch(descriptor)
        },
        add: { item in
            @Dependency(SwiftDataClient.self) var swiftDataClient
            let context = try swiftDataClient.context()
            context.insert(item)
        },
        delete: { item in
            @Dependency(SwiftDataClient.self) var swiftDataClient
            let context = try swiftDataClient.context()
            context.delete(item)
        }
    )
}
