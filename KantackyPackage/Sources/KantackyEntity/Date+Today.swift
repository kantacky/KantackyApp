import Foundation

public extension Date {
    static var today: Self {
        Calendar.current.date(byAdding: .day, value: 0, to: Calendar.current.startOfDay(for: Date()))!
    }
}
