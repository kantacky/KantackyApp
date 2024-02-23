import Account
import ComposableArchitecture
import SwiftUI

struct CoreView: View {
    let store: StoreOf<Core>

    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView {
                AccountView(store: store.scope(
                    state: \.account,
                    action: \.account
                ))
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle")
                }
            }
        }
    }
}

#Preview {
    CoreView(store: Store(
        initialState: Core.State(
            user: .example0
        )
    ) {
        Core()
    })
}
