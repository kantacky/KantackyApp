import ComposableArchitecture
import Resources
import SwiftUI

public struct LaunchView: View {
    private let store: StoreOf<Launch>

    public init(store: StoreOf<Launch>) {
        self.store = store
    }

    public var body: some View {
        VStack(spacing: 64) {
            Image.kantacky
                .resizable()
                .scaledToFit()
                .frame(width: 128)
            ProgressView()
        }
        .onAppear {
            store.send(.onAppear)
        }
    }
}

#Preview {
    LaunchView(
        store: Store(initialState: Launch.State()) {
            Launch()
        }
    )
}
