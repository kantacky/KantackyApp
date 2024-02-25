import ComposableArchitecture
import Root
import SwiftUI

public struct AppRoot: App {
    private let store: StoreOf<Root>

    public init() {
        self.store = Store(initialState: Root.State()) {
            Root()
        }
    }

    public var body: some Scene {
        WindowGroup {
            RootView(store: store)
#if os(macOS)
                .frame(minWidth: 800, minHeight: 600)
#endif
        }
    }
}
