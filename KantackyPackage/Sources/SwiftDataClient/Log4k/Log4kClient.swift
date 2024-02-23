import Data
import SwiftData

public struct Log4kClient {
    public var fetchAll: @Sendable () throws -> [Log4kItem]
    public var fetch: @Sendable (FetchDescriptor<Log4kItem>) throws -> [Log4kItem]
    public var add: @Sendable (Log4kItem) throws -> Void
    public var delete: @Sendable (Log4kItem) throws -> Void

    public init(
        fetchAll: @escaping @Sendable () throws -> [Log4kItem],
        fetch: @escaping @Sendable (FetchDescriptor<Log4kItem>) throws -> [Log4kItem],
        add: @escaping @Sendable (Log4kItem) throws -> Void,
        delete: @escaping @Sendable (Log4kItem) throws -> Void
    ) {
        self.fetchAll = fetchAll
        self.fetch = fetch
        self.add = add
        self.delete = delete
    }
}
