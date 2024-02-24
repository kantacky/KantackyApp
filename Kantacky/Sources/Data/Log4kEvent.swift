import Foundation
import SwiftData

@Model
public final class Log4kEvent {
    public var date: Date = Date.now
    public var title: String = ""
    public var note: String = ""

    public var log4kItem: Log4kItem?

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
