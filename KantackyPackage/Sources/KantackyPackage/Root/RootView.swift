import ComposableArchitecture
import SignIn
import SwiftUI

struct RootView: View {
    let store: StoreOf<Root>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            SwitchStore(self.store.scope(state: \.scene, action: \.self)) { scene in
                switch scene {
                case .launch:
                    LaunchView()
                        .onAppear {
                            viewStore.send(.onAppear)
                        }

                case .signIn:
                    CaseLet(
                        /Root.State.Scene.signIn,
                         action: Root.Action.signIn
                    ) { store in
                        SignInView(store: store)
                    }

                case .core:
                    CaseLet(
                        /Root.State.Scene.core,
                         action: Root.Action.core
                    ) { store in
                        CoreView(store: store)
                    }
                }
            }
            .alert(store: self.store.scope(state: \.$alert, action: \.alert))
        }
    }
}

#Preview {
    RootView(store: Store(initialState: Root.State()) {
        Root()
    })
}
