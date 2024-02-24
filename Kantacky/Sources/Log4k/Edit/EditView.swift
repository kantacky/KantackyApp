import ComposableArchitecture
import Data
import SwiftUI

public struct EditView: View {
    @Bindable private var store: StoreOf<Edit>

    public init(store: StoreOf<Edit>) {
        self.store = store
    }

    public var body: some View {
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
                    Slider(value: $store.item.evaluation.happy, in: 0...10, step: 1)
                }

                LabeledContent("Satisfied?") {
                    Slider(value: $store.item.evaluation.satisfied, in: 0...10, step: 1)
                }

                LabeledContent("Exhausted?") {
                    Slider(value: $store.item.evaluation.exhausted, in: 0...10, step: 1)
                }
            }
        }
        .navigationTitle("New Log4k")
        .navigationBarTitleDisplayMode(.inline)
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

#Preview {
    EditView(store: Store(initialState: Edit.State(
        item: Log4kItem(
            date: .today,
            evaluation: Log4kEvaluation(
                happy: 5,
                satisfied: 5,
                exhausted: 5
            ),
            events: []
        )
    )) {
        Edit()
    })
}
