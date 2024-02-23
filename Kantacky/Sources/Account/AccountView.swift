import ComposableArchitecture
import NukeUI
import SwiftUI

public struct AccountView: View {
    @Bindable private var store: StoreOf<Account>

    public init(store: StoreOf<Account>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 16) {
                        LazyImage(url: store.user.avator) { state in
                            if let image = state.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 48)
                                    .clipShape(Circle())
                            } else if state.error != nil {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 48, height: 48)
                            } else {
                                Circle()
                                    .fill(Color.gray)
                                    .frame(width: 48, height: 48)
                            }
                        }

                        VStack(alignment: .leading) {
                            Text(store.user.name)
                                .font(.title3)
                            Text(store.user.email)
                                .font(.caption)
                        }
                    }
                }

                Section {
                    Button(role: .destructive) {
                        store.send(.onSignOutButtonTapped)
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Sign Out")
                        }
                    }
                }
            }
            .refreshable {
                store.send(.onPullToRefresh)
            }
            .navigationTitle("Account")
        }
    }
}

#Preview {
    AccountView(store: Store(
        initialState: Account.State(user: .example0)
    ) {
        Account()
    })
}
