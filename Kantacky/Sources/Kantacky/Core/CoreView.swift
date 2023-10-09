import ComposableArchitecture
import SignIn
import SwiftUI

struct CoreView: View {
    typealias Reducer = CoreReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    var body: some View {
        SwitchStore(self.store) { state in
            switch state {
            case .signIn:
                CaseLet(/Reducer.State.signIn, action: Reducer.Action.signIn) { store in
                    SignInView(store: store)
                }

            case .main:
                CaseLet(/Reducer.State.main, action: Reducer.Action.main) { store in
                    MainView(store: store)
                }
            }
        }
    }
}

#Preview {
    CoreView(store: Store(
        initialState: CoreView.Reducer.State(),
        reducer: { CoreView.Reducer() }
    ))
}
