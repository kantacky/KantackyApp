import Foundation
import GoogleGenerativeAI

struct ChatHistoryItem: Identifiable, Equatable {
    let id: UUID = UUID()
    let role: ChatRole
    let text: String

    var modelContent: ModelContent {
        ModelContent(role: role.rawValue, text)
    }
}
