import Account
import ComposableArchitecture
import Dependencies
import SwiftUI

public struct CoreView: View {
    private let store: StoreOf<Core>

    public init(store: StoreOf<Core>) {
        self.store = store
    }

    public var body: some View {
        TabView {
            AccountView(
                store: store.scope(
                    state: \.account,
                    action: \.account
                )
            )
            .tabItem {
                Label("Account", systemImage: "person.crop.circle")
            }
        }
    }
}

#Preview {
    CoreView(store: Store(initialState: Core.State(
        user: .example0
    )) { Core() })
}
