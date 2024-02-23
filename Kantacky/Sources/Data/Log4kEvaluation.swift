import Foundation

public struct Log4kEvaluation: Codable {
    public var happy: Int = 0
    public var satisfied: Int = 0
    public var exauhsted: Int = 0

    public init(
        happy: Int,
        satisfied: Int,
        exauhsted: Int
    ) {
        self.happy = happy
        self.satisfied = satisfied
        self.exauhsted = exauhsted
    }
}

