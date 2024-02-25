import ComposableArchitecture
import Data
import SwiftUI

public struct DetailView: View {
    @Bindable private var store: StoreOf<Detail>

    public init(store: StoreOf<Detail>) {
        self.store = store
    }

    public var body: some View {
        Form {
            LabeledContent("Date") {
                Text(DateFormatter.dateFormatter.string(from: store.item.date))
            }

            Section(header: Text("Evaluation")) {
                LabeledContent("Happy?") {
                    Text(store.item.happy.description)
                }

                LabeledContent("Satisfied?") {
                    Text(store.item.satisfied.description)
                }

                LabeledContent("Exhausted?") {
                    Text(store.item.exhausted.description)
                }
            }
        }
        .navigationTitle(DateFormatter.dateFormatter.string(from: store.item.date))
#if !os(macOS)
        .navigationBarTitleDisplayMode(.inline)
#endif
        .toolbar {
#if !os(macOS)
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Edit") {
                    store.send(.editButtonTapped)
                }
            }
#else
            ToolbarItem {
                Button("Edit") {
                    store.send(.editButtonTapped)
                }
            }
#endif
        }
    }
}

#Preview {
    DetailView(store: Store(
        initialState: Detail.State(
            item: Log4kItem(
                date: .today,
                happy: 5,
                satisfied: 5,
                exhausted: 5,
                events: []
            )
        )
    ) {
        Detail()
    })
}
