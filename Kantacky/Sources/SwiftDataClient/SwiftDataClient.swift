import SwiftData

public struct SwiftDataClient {
    public var context: @Sendable () throws -> ModelContext

    public init(
        context: @escaping @Sendable () throws -> ModelContext
    ) {
        self.context = context
    }
}
