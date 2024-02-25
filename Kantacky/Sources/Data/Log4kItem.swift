import Foundation
import SwiftData

@Model
public final class Log4kItem {
    public var date: Date = Date.today
    public var happy: Double = 0
    public var satisfied: Double = 0
    public var exhausted: Double = 0

    @Relationship(deleteRule: .cascade)
    public var events: [Log4kEvent]? = []

    public init(
        date: Date,
        happy: Double,
        satisfied: Double,
        exhausted: Double,
        events: [Log4kEvent]
    ) {
        self.date = date
        self.happy = happy
        self.satisfied = satisfied
        self.exhausted = exhausted
        self.events = events
    }
}
