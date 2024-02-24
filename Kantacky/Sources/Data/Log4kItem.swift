import Foundation
import SwiftData

@Model
public final class Log4kItem {
    public var date: Date = Date.now
    public var evaluation: Log4kEvaluation = Log4kEvaluation(happy: 0, satisfied: 0, exhausted: 0)

    @Relationship(deleteRule: .cascade, minimumModelCount: 1, maximumModelCount: 1)
    public var events: [Log4kEvent]? = []

    public init(
        date: Date,
        evaluation: Log4kEvaluation,
        events: [Log4kEvent]
    ) {
        self.date = date
        self.evaluation = evaluation
        self.events = events
    }
}
