import Foundation
import SwiftData

public struct Log4kEvaluation: Codable {
    public var happy: Float = 0
    public var satisfied: Float = 0
    public var exhausted: Float = 0

    public init(
        happy: Float,
        satisfied: Float,
        exhausted: Float
    ) {
        self.happy = happy
        self.satisfied = satisfied
        self.exhausted = exhausted
    }
}
