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
