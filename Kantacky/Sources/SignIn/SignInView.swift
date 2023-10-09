import ComposableArchitecture
import SwiftUI

public struct SignInView: View {
    public typealias Reducer = SignInReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    public var body: some View {
        VStack(spacing: 32) {
            Image(.kantacky)
                .resizable()
                .scaledToFit()
                .frame(width: 64)

            Text("Sign In to Kantacky")
                .font(.title)
                .bold()

            UsernameTextField(
                text: self.viewStore.binding(
                    get: \.username,
                    send: Reducer.Action.onUsernameChanged
                ),
                placeholder: "Username"
            )

            SignInButton("Sign In") {
                self.viewStore.send(.onSignInButtonTapped)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    SignInView(store: Store(
        initialState: SignInView.Reducer.State(),
        reducer: { SignInView.Reducer() }
    ))
}
