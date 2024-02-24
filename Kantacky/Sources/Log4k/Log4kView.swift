import ComposableArchitecture
import Data
import SwiftData
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
        NavigationStack {
            List(items.sorted(by: { $0.date > $1.date })) { item in
                Text(DateFormatter.dateFormatter.string(from: item.date))
                    .swipeActions {
                        Button("Delete", systemImage: "trash", role: .destructive) {
                            context.delete(item)
                        }
                    }
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
            .navigationDestination(
                item: $store.scope(state: \.destination?.detail, action: \.destination.detail)
            ) { store in
                DetailView(store: store)
            }
            .toolbar {
#if !os(macOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        store.send(.plusButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
#else
                ToolbarItem {
                    Button {
                        store.send(.plusButtonTapped)
                    } label: {
                        Image(systemName: "plus")
                    }
                }
#endif
            }
            .navigationTitle("Log4k")
        }
        .alert(
            $store.scope(state: \.alert, action: \.alert)
        )
    }
}

#Preview {
    Log4kView(store: Store(initialState: Log4k.State()) {
        Log4k()
    })
    .modelContainer(for: [Log4kItem.self])
}
