import ComposableArchitecture
import SwiftUI

struct NoLogView: View {
    let store: StoreOf<Log4k>

    var body: some View {
        VStack(spacing: 32) {
            Image(systemName: "pencil.and.list.clipboard")
                .font(.system(size: 48))
                .bold()
                .foregroundStyle(.secondary)

            VStack(spacing: 16) {
                Text("NO LOG")
                    .font(.title)
                    .bold()
                    .foregroundStyle(.secondary)

                Button {
                    store.send(.plusButtonTapped)
                } label: {
                    Label("Add First Log", systemImage: "plus")
                }
            }
        }
    }
}

#Preview {
    NoLogView(store: Store(initialState: Log4k.State()) {
        Log4k()
    })
}
