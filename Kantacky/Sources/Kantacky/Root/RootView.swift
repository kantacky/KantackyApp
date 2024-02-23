import ComposableArchitecture
import SignIn
import SwiftUI

struct RootView: View {
    let store: StoreOf<Root>

    var body: some View {
        switch store.state {
        case .launch:
            LaunchView()
                .onAppear {
                    store.send(.onAppear)
                }

        case .signIn:
            if let store = store.scope(
                state: \.signIn,
                action: \.signIn
            ) {
                SignInView(store: store)
            }

        case .core:
            if let store = store.scope(
                state: \.core,
                action: \.core
            ) {
                CoreView(store: store)
            }
        }
    }
}

#Preview {
    RootView(store: Store(initialState: Root.State()) {
        Root()
    })
}
