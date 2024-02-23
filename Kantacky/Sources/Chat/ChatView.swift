import ComposableArchitecture
import Resources
import SwiftUI

public struct ChatView: View {
    @Bindable private var store: StoreOf<Chat>
    @FocusState private var isFocused: Bool

    public init(store: StoreOf<Chat>) {
        self.store = store
    }

    public var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                ScrollViewReader { reader in
                    ScrollView {
                        Group {
                            ForEach(store.history) { item in
                                HStack(alignment: .top) {
                                    switch item.role {
                                    case .model:
                                        Image.gemini
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                            .padding(4)
                                        Text(item.text)
                                            .padding()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(.secondary)
                                            )
                                        Spacer()

                                    case .user:
                                        Spacer()
                                        Text(item.text)
                                            .padding()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 8)
                                                    .stroke(.secondary)
                                            )
                                        Image.kantacky
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 24, height: 24)
                                            .padding(4)
                                    }
                                }
                                .padding()
                            }

                            if store.isLoading {
                                HStack(alignment: .top) {
                                    Image.gemini
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                        .padding(.horizontal, 4)
                                    ProgressView()
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(.secondary)
                                        )
                                    Spacer()
                                }
                            }
                        }
                        .padding(.bottom)

                        Divider()
                            .padding()
                            .id("last")
                    }
                    .onAppear {
                        withAnimation(.default) {
                            reader.scrollTo("last", anchor: .bottom)
                        }
                    }
                    .onChange(of: store.isLoading) { _, _ in
                        withAnimation(.default) {
                            reader.scrollTo("last", anchor: .bottom)
                        }
                    }
                }

                HStack {
                    TextField("Prompt here...", text: $store.prompt)
                        .focused($isFocused)

                    Button {
                        store.send(.onSubmitButtonTapped, animation: .smooth(duration: 0.5))
                    } label: {
                        Image(systemName: "paperplane.fill")
                            .foregroundStyle(.primary)
                    }
                    .disabled(store.isLoading)
                }
                .padding()
                .overlay(
                    Capsule()
                        .stroke(.secondary)
                )
                .padding(.bottom)
                .padding(.horizontal)
            }
            .gesture(
                DragGesture()
                    .onEnded({ value in
                        if (value.translation.height > 10) {
                            isFocused = false
                        }
                    })
            )
            .navigationTitle("Chat with Gemini")
            .toolbar {
                if isFocused {
#if !os(macOS)
                    ToolbarItem(placement: .topBarLeading) {
                        Button("Cancel") {
                            isFocused = false
                        }
                    }
#else
                    ToolbarItem {
                        Button("Cancel") {
                            isFocused = false
                        }
                    }
#endif
                }

                if !store.history.isEmpty {
#if !os(macOS)
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Clear") {
                            store.send(.onClearButtonTapped)
                        }
                    }
#else
                    ToolbarItem {
                        Button("Clear") {
                            store.send(.onClearButtonTapped)
                        }
                    }
#endif
                }
            }
        }
    }
}

#Preview {
    ChatView(store: Store(initialState: Chat.State()) {
        Chat()
    })
}
