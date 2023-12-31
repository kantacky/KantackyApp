import ComposableArchitecture
import NukeUI
import SwiftUI

public struct AccountView: View {
    public typealias Reducer = AccountReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(
            wrappedValue: ViewStore(store, observe: { $0 })
        )
    }

    public var body: some View {
        NavigationStack {
            Form {
                Section {
                    HStack(spacing: 16) {
                        LazyImage(url: self.viewStore.user.avator) { state in
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
                            Text(self.viewStore.user.name)
                                .font(.title3)
                            Text(self.viewStore.user.email)
                                .font(.caption)
                        }
                    }
                }

                Section(header: Label("Edit Info", systemImage: "person.fill")) {
                    NavigationLink {
                        Form {
                            TextField("Name", text: self.viewStore.$user.name)
                        }
                    } label: {
                        LabeledContent("Name", value: self.viewStore.user.name)
                    }
                    .onSubmit {
                        self.viewStore.send(.onNameChanged)
                    }

                    NavigationLink {
                        Form {
                            TextField("Email", text: self.viewStore.$user.email)
                        }
                    } label: {
                        LabeledContent("Email", value: "\(self.viewStore.user.email)\(self.viewStore.user.isEmailVerified ? "" : " - Not Verified")")
                    }
                    .onSubmit {
                        self.viewStore.send(.onEmailChanged)
                    }
                }

                Section {
                    Button(role: .destructive) {
                        self.viewStore.send(.onSignOutButtonTapped)
                    } label: {
                        HStack {
                            Image(systemName: "rectangle.portrait.and.arrow.right")
                            Text("Sign Out")
                        }
                    }
                }
            }
            .refreshable {
                self.viewStore.send(.onPullToRefresh)
            }
            .navigationTitle("Account")
        }
    }
}

#Preview {
    AccountView(store: Store(
        initialState: AccountView.Reducer.State(user: .example0)
    ) {
        AccountView.Reducer()
    })
}
