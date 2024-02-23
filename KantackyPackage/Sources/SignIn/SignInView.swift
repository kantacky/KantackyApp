import ComposableArchitecture
import Resources
import SwiftUI

public struct SignInView: View {
    public typealias Reducer = SignInReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(
            wrappedValue: ViewStore(store, observe: { $0 })
        )
    }

    public var body: some View {
        VStack(spacing: 32) {
            Spacer()
                .frame(maxHeight: 48)

            Image.kantacky
                .resizable()
                .scaledToFit()
                .frame(width: 64)

            Text("Sign In to Kantacky")
                .font(.title)
                .bold()

            Button {
                self.viewStore.send(.onContinueButtonTapped, animation: .smooth(duration: 0.5))
            } label: {
                Text("Continue")
                    .frame(width: 128, height: 48)
            }
            .foregroundStyle(.white)
            .background(.blue)
            .clipShape(Capsule())

            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    SignInView(store: Store(
        initialState: SignInView.Reducer.State()
    ) {
        SignInView.Reducer()
    })
}
