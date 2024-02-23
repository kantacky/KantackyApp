import Foundation

public struct Log4kEvent: Codable {
    public var date: Date = Date.now
    public var title: String = ""
    public var note: String = ""

    public init(
        date: Date,
        title: String,
        note: String
    ) {
        self.date = date
        self.title = title
        self.note = note
    }
}
