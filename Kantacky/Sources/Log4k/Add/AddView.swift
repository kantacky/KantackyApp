import ComposableArchitecture
import SwiftUI

public struct AddView: View {
    @Bindable private var store: StoreOf<Add>

    public init(store: StoreOf<Add>) {
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
            .navigationTitle("New Log4k")
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
    }
}

#Preview {
    AddView(store: Store(initialState: Add.State()) {
        Add()
    })
}
