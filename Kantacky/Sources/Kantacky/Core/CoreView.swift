import Account
import Chat
import ComposableArchitecture
import Dependencies
import Log4k
import SwiftData
import SwiftDataClient
import SwiftUI

struct CoreView: View {
    let store: StoreOf<Core>
    @Dependency(SwiftDataClient.self) private var swiftDataClient
    var context: ModelContext {
        do {
            let modelContext = try self.swiftDataClient.context()
            return modelContext
        } catch {
            fatalError("Could not find modelContext")
        }
    }

    var body: some View {
        TabView {
            ChatView(
                store: store.scope(
                    state: \.chat,
                    action: \.chat
                )
            )
            .tabItem {
                Label("Chat", systemImage: "message")
            }

            Log4kView(
                store: store.scope(
                    state: \.log4k,
                    action: \.log4k
                )
            )
            .modelContext(context)
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
