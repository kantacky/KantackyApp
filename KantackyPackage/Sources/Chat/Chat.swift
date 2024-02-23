import ComposableArchitecture
import Dependencies
import GenerativeAIClient
import GoogleGenerativeAI

@Reducer
public struct Chat {
    // MARK: - State
    @ObservableState
    public struct State: Equatable {
        var prompt: String
        var history: [ChatHistoryItem]
        var isLoading: Bool

        public init() {
            self.prompt = ""
            self.history = []
            self.isLoading = false
        }
    }

    // MARK: - Action
    public enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onAppear
        case onClearButtonTapped
        case onSubmitButtonTapped
        case aiResult(Result<String, Error>)
    }

    // MARK: - Dependencies
    @Dependency(GenerativeAIClient.self) private var aiClient

    public init() {}

    private enum CancelID {
        case chatRequest
    }

    // MARK: - Reducer
    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .binding:
                return .none

            case .onAppear:
                return .none

            case .onClearButtonTapped:
                state.prompt = ""
                state.history = []
                state.isLoading = false
                return .cancel(id: CancelID.chatRequest)

            case .onSubmitButtonTapped:
                if state.prompt.isEmpty {
                    return .none
                }
                state.history.append(ChatHistoryItem(role: .user, text: state.prompt))
                state.prompt = ""
                state.isLoading = true
                return .run { [prompt = state.prompt] send in
                    await send(.aiResult(Result {
//                        var contents = history.map(\.modelContent)
//                        contents.removeLast()
                        return try await aiClient.generate(prompt)
                    }))
                }
                .cancellable(id: CancelID.chatRequest)

            case .aiResult(.success(let response)):
                state.history.append(ChatHistoryItem(role: .model, text: response))
                state.prompt = ""
                state.isLoading = false
                return .none

            case .aiResult(.failure(let error)):
                debugPrint(error.localizedDescription)
                state.history.append(ChatHistoryItem(role: .model, text: error.localizedDescription))
                state.prompt = ""
                state.isLoading = false
                return .none
            }
        }
    }
}
