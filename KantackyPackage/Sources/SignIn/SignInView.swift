import ComposableArchitecture
import Resources
import SwiftUI

public struct SignInView: View {
    private let store: StoreOf<SignIn>

    public init(store: StoreOf<SignIn>) {
        self.store = store
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
                store.send(.onContinueButtonTapped, animation: .smooth(duration: 0.5))
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
        initialState: SignIn.State()
    ) {
        SignIn()
    })
}
