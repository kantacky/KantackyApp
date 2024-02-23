import Foundation
import SwiftData

@Model
public final class Log4kItem {
    public var id: UUID = UUID()
    public var date: Date = Date.now
    public var evaluation: Log4kEvaluation = Log4kEvaluation(happy: 0, satisfied: 0, exauhsted: 0)
    public var events: [Log4kEvent] = []

    public init(
        id: UUID,
        date: Date,
        evaluation: Log4kEvaluation,
        events: [Log4kEvent]
    ) {
        self.id = id
        self.date = date
        self.evaluation = evaluation
        self.events = events
    }
}
