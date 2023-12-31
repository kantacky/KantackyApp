import ComposableArchitecture
import SignIn
import SwiftUI

struct CoreView: View {
    typealias Reducer = CoreReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(
            wrappedValue: ViewStore(store, observe: { $0 })
        )
    }

    var body: some View {
        SwitchStore(self.store.scope(state: \.scene, action: \.self)) { scene in
            switch scene {
            case .launch:
                LaunchView()
                    .onAppear {
                        self.viewStore.send(.onAppear)
                    }

            case .signIn:
                CaseLet(/Reducer.State.Scene.signIn, action: Reducer.Action.signIn) { store in
                    SignInView(store: store)
                }

            case .main:
                CaseLet(/Reducer.State.Scene.main, action: Reducer.Action.main) { store in
                    MainView(store: store)
                }
            }
        }
        .alert(store: self.store.scope(state: \.$alert, action: \.alert))
    }
}

#Preview {
    CoreView(store: Store(
        initialState: CoreView.Reducer.State()
    ) {
        CoreView.Reducer()
    })
}
