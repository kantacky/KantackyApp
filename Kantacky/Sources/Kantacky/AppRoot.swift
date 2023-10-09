import ComposableArchitecture
import SwiftUI

public struct AppRoot: App {
    private let store: StoreOf<CoreReducer>

    public init() {
        self.store = Store(
            initialState: CoreReducer.State(),
            reducer: { CoreReducer() }
        )
    }

    public var body: some Scene {
        WindowGroup {
            CoreView(store: self.store)
        }
    }
}
