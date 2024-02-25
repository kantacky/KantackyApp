import ComposableArchitecture
import SwiftUI

struct Log4kToolbar: ViewModifier {
    let store: StoreOf<Log4k>
    
    func body(content: Content) -> some View {
        content
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
    }
}

#Preview {
    NavigationStack {
        List {}
            .modifier(Log4kToolbar(store: Store(initialState: Log4k.State()) {
                Log4k()
            }))
    }
}
