import ComposableArchitecture
import Data
import Dependencies
import SwiftData
import SwiftDataClient
import SwiftUI

public struct Log4kView: View {
    @Environment(\.modelContext) private var context
    @Bindable private var store: StoreOf<Log4k>

    public init(store: StoreOf<Log4k>) {
        self.store = store
    }

    @Query private var items: [Log4kItem] {
        didSet {
            store.send(.queryChanged(items))
        }
    }

    public var body: some View {
        NavigationSplitView {
            List(
                items.sorted(by: { $0.date > $1.date }),
                selection: $store.selection.sending(\.selectionChanged)
            ) { item in
                NavigationLink(
                    DateFormatter.dateFormatter.string(from: item.date),
                    value: item
                )
                .swipeActions {
                    Button("Delete", systemImage: "trash", role: .destructive) {
                        context.delete(item)
                    }
                }
            }
#if os(macOS)
            .frame(minWidth: 200)
#endif
            .modifier(Log4kToolbar(store: store))
            .navigationDestination(
                item: $store.scope(state: \.destination?.detail, action: \.destination.detail)
            ) { store in
                DetailView(store: store)
            }
            .navigationTitle("Log4k")
        } detail: {
            Text("Select an Item")
#if os(macOS)
                .frame(minWidth: 600, minHeight: 600)
#endif
        }
        .sheet(
            item: $store.scope(state: \.destination?.add, action: \.destination.add)
        ) { store in
            AddView(store: store)
        }
        .popover(
            item: $store.scope(state: \.destination?.edit, action: \.destination.edit)
        ) { store in
            EditView(store: store)
        }
        .alert(
            $store.scope(state: \.alert, action: \.alert)
        )
    }
}

#Preview {
    @Dependency(SwiftDataClient.self) var swiftDataClient

    return Log4kView(store: Store(initialState: Log4k.State()) {
        Log4k()
    })
    .modelContainer(swiftDataClient.container)
}
