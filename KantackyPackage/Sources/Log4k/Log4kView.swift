import ComposableArchitecture
import Data
import SwiftData
import SwiftUI

public struct Log4kView: View {
    private let store: StoreOf<Log4k>

    public init(store: StoreOf<Log4k>) {
        self.store = store
    }

    @Query private var items: [Log4kItem] {
        didSet {
            store.send(.queryChanged(self.items))
        }
    }

    public var body: some View {
        NavigationStack {
            List(items) { item in
                Text("\(item.date)")
            }
            .refreshable {
                store.send(.reload)
            }
            .navigationTitle("Log4k")
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    Log4kView(store: Store(initialState: Log4k.State()) {
        Log4k()
    })
}
