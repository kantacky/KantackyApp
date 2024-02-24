import Account
import ComposableArchitecture
import Dependencies
import Log4k
import SwiftData
import SwiftDataClient
import SwiftUI

public struct CoreView: View {
    private let store: StoreOf<Core>
    @Dependency(SwiftDataClient.self) private var swiftDataClient

    public init(store: StoreOf<Core>) {
        self.store = store
    }

    public var body: some View {
        TabView {
            Log4kView(
                store: store.scope(
                    state: \.log4k,
                    action: \.log4k
                )
            )
            .modelContainer(swiftDataClient.container)
            .tabItem {
                Label("Log4k", systemImage: "pencil.and.list.clipboard")
            }

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
    CoreView(store: Store(
        initialState: Core.State(
            user: .example0
        )
    ) {
        Core()
    })
}
