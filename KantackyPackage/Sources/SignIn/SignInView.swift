import ComposableArchitecture
import Resources
import SwiftUI

public struct SignInView: View {
    @Bindable private var store: StoreOf<SignIn>

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

            Button("Continue") {
                store.send(.continueButtonTapped)
            }
            .buttonStyle(.borderedProminent)

            Spacer()
        }
        .padding(.horizontal)
        .alert($store.scope(state: \.alert, action: \.alert))
    }
}

#Preview {
    SignInView(
        store: Store(
            initialState: SignIn.State()
        ) {
            SignIn()
        }
    )
}
