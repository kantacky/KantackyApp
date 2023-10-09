import ComposableArchitecture
import SwiftUI

public struct AccountView: View {
    public typealias Reducer = AccountReducer
    private let store: StoreOf<Reducer>
    @StateObject private var viewStore: ViewStoreOf<Reducer>

    public init(store: StoreOf<Reducer>) {
        self.store = store
        self._viewStore = .init(wrappedValue: ViewStore(store, observe: { $0 }))
    }

    public var body: some View {
        NavigationStack {
            Form {
                Section(header: Label("Basic Info", systemImage: "person")) {
                    NavigationLink {
                        Form {
                            Section {
                                LabeledContent("Username") {
                                    TextField("Username", text: self.viewStore.binding(
                                        get: \.user.username,
                                        send: Reducer.Action.onUsernameChanged
                                    ))
                                    .keyboardType(.alphabet)
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                                    .multilineTextAlignment(.trailing)
                                }
                            }
                        }
                        .navigationTitle("Username")
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        LabeledContent("Username") {
                            Text(self.viewStore.user.username)
                        }
                    }

                    NavigationLink {
                        Form {
                            LabeledContent("First Name") {
                                TextField("First Name", text: self.viewStore.binding(
                                    get: \.user.firstname,
                                    send: Reducer.Action.onFirstnameChanged
                                ))
                                .autocorrectionDisabled()
                                .multilineTextAlignment(.trailing)
                            }

                            LabeledContent("Middle Name") {
                                TextField("Middle Name", text: self.viewStore.binding(
                                    get: \.user.middlename,
                                    send: Reducer.Action.onMiddlenameChanged
                                ))
                                .autocorrectionDisabled()
                                .multilineTextAlignment(.trailing)
                            }

                            LabeledContent("Last Name") {
                                TextField("Last Name", text: self.viewStore.binding(
                                    get: \.user.lastname,
                                    send: Reducer.Action.onLastnameChanged
                                ))
                                .autocorrectionDisabled()
                                .multilineTextAlignment(.trailing)
                            }
                        }
                        .navigationTitle("Name")
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        LabeledContent("Name") {
                            Text(self.viewStore.user.fullname)
                        }
                    }

                    NavigationLink {
                        Form {
                            Section {
                                LabeledContent("Email") {
                                    TextField("Email", text: self.viewStore.binding(
                                        get: \.user.email,
                                        send: Reducer.Action.onEmailChanged
                                    ))
                                    .keyboardType(.emailAddress)
                                    .autocorrectionDisabled()
                                    .textInputAutocapitalization(.never)
                                    .multilineTextAlignment(.trailing)
                                }
                            }
                        }
                        .navigationTitle("Edit Email")
                        .navigationBarTitleDisplayMode(.inline)
                    } label: {
                        LabeledContent("Email") {
                            Text(self.viewStore.user.email)
                        }
                    }
                }

                Section(header: Label("Security", systemImage: "lock")) {
                    switch self.viewStore.user.authMethod {
                    case .passkey:
                        NavigationLink {
                            List {
                                Section {
                                    ForEach(self.viewStore.user.passkeys, id: \.self) { passkey in
                                        NavigationLink {
                                            Form {
                                                HStack {
                                                    Text("Passkey Name")

                                                    Spacer()

                                                    TextField(text: .constant(passkey)) {
                                                        Text("Passkey Name")
                                                    }
                                                    .multilineTextAlignment(.trailing)
                                                }
                                            }
                                            .navigationTitle("Edit Passkey")
                                            .navigationBarTitleDisplayMode(.inline)
                                        } label: {
                                            Text(passkey)
                                        }
                                    }
                                }
                            }
                            .navigationTitle("Passkeys")
                            .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            HStack {
                                Image(systemName: "person.badge.key.fill")
                                Text("Passkeys")
                            }
                        }

                    case .password:
                        NavigationLink {
                            Form {
                                Section {
                                    LabeledContent("Password") {
                                        SecureField("8 letters or more", text: .constant(""))
                                            .multilineTextAlignment(.trailing)
                                    }


                                    LabeledContent("Password (Confirm)") {
                                        SecureField("Same as above", text: .constant(""))
                                            .multilineTextAlignment(.trailing)
                                    }
                                }
                            }
                            .navigationTitle("Password")
                            .navigationBarTitleDisplayMode(.inline)
                        } label: {
                            Text("Password")
                        }

                        Button {
                            self.viewStore.send(.onUsePasskeyButtonTapped)
                        } label: {
                            HStack {
                                Image(systemName: "person.badge.key.fill")
                                Text("Use Passkey instead of Password")
                            }
                        }
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
            .navigationTitle("Account")
        }
    }
}

#Preview {
    AccountView(store: Store(
        initialState: AccountView.Reducer.State(user: .example0),
        reducer: { AccountView.Reducer() }
    ))
}

#Preview {
    AccountView(store: Store(
        initialState: AccountView.Reducer.State(user: .example1),
        reducer: { AccountView.Reducer() }
    ))
}
