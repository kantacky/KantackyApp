import Account
import ComposableArchitecture
import SwiftUI

struct MainView: View {
    typealias Reducer = MainReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(
            wrappedValue: ViewStore(store, observe: { $0 })
        )
    }

    var body: some View {
        TabView {
            AccountView(store: self.store.scope(
                state: \.account,
                action: { Reducer.Action.account($0) }
            ))
            .tabItem {
                Label("Account", systemImage: "person.crop.circle")
            }
        }
    }
}

#Preview {
    MainView(store: Store(
        initialState: MainView.Reducer.State(user: .example0)
    ) {
        MainView.Reducer()
    })
}
