import ComposableArchitecture
import Data
import SwiftUI

public struct EditView: View {
    @Bindable private var store: StoreOf<Edit>

    public init(store: StoreOf<Edit>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            Form {
                LabeledContent("Date") {
                    DatePicker(
                        "Date",
                        selection: $store.item.date,
                        displayedComponents: [.date]
                    )
                }

                Section(header: Text("Evaluation")) {
                    LabeledContent("Happy?") {
                        HStack {
                            Spacer()
                            Text(store.item.happy.description)
                            Slider(value: $store.item.happy, in: 0...5, step: 0.5)
                                .containerRelativeFrame(.horizontal, count: 2, spacing: 0)
                        }
                    }

                    LabeledContent("Satisfied?") {
                        HStack {
                            Spacer()
                            Text(store.item.satisfied.description)
                            Slider(value: $store.item.satisfied, in: 0...5, step: 0.5)
                                .containerRelativeFrame(.horizontal, count: 2, spacing: 0)
                        }
                    }

                    LabeledContent("Exhausted?") {
                        HStack {
                            Spacer()
                            Text(store.item.exhausted.description)
                            Slider(value: $store.item.exhausted, in: 0...5, step: 0.5)
                                .containerRelativeFrame(.horizontal, count: 2, spacing: 0)
                        }
                    }
                }
            }
            .navigationTitle(DateFormatter.dateFormatter.string(from: store.item.date))
#if !os(macOS)
            .navigationBarTitleDisplayMode(.inline)
#endif
            .toolbar {
#if !os(macOS)
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        store.send(.cancelButtonTapped)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        store.send(.saveButtonTapped)
                    }
                }
#else
                ToolbarItem {
                    Button("Cancel") {
                        store.send(.cancelButtonTapped)
                    }
                }
                ToolbarItem {
                    Button("Save") {
                        store.send(.saveButtonTapped)
                    }
                }
#endif
            }
        }
        .onDisappear {
            store.send(.onDisappear)
        }
    }
}

#Preview {
    EditView(store: Store(initialState: Edit.State(
        item: Log4kItem(
            date: .today,
            happy: 5,
            satisfied: 5,
            exhausted: 5,
            events: []
        )
    )) {
        Edit()
    })
}
