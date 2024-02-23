import Dependencies
import GoogleGenerativeAI

public struct GenerativeAIClient {
    public var generate: @Sendable (String) async throws -> String
    public var chat: @Sendable ([ModelContent], String) async throws -> String

    public init(
        generate: @escaping @Sendable (String) async throws -> String,
        chat: @escaping @Sendable ([ModelContent], String) async throws -> String
    ) {
        self.generate = generate
        self.chat = chat
    }
}

extension GenerativeAIClient: DependencyKey {
    public static let liveValue: Self = .init(
        generate: { prompt in
            let model = GenerativeModel(
                name: "gemini-pro",
                apiKey: APIKey.default
            )
            let response = try await model.generateContent(prompt)
            guard let text = response.text else {
                return ""
            }
            return text
        },
        chat: { history, prompt in
            let config = GenerationConfig()
            let model = GenerativeModel(
                name: "gemini-pro",
                apiKey: APIKey.default,
                generationConfig: config
            )
            let chat = model.startChat(history: history)
            let response = try await chat.sendMessage(prompt)
            guard let text = response.text else {
                return ""
            }
            return text
        }
    )
}
