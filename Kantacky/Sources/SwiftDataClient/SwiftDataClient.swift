import SwiftData

public struct SwiftDataClient {
    public var container: ModelContainer

    public init(
        container: ModelContainer
    ) {
        self.container = container
    }
}
