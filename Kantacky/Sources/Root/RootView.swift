import ComposableArchitecture
import Core
import Launch
import SignIn
import SwiftUI

public struct RootView: View {
    private let store: StoreOf<Root>

    public init(store: StoreOf<Root>) {
        self.store = store
    }

    public var body: some View {
        switch store.scope(state: \.scene, action: \.scene).case {
        case let .launch(store):
            LaunchView(store: store)

        case let .signIn(store):
            SignInView(store: store)

        case let .core(store):
            CoreView(store: store)
        }
    }
}

#Preview {
    RootView(store: Store(initialState: Root.State()) {
        Root()
    })
}
