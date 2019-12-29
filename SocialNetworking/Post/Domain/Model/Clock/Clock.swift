
import Foundation

//sourcery: AutoMockable
protocol Clock {
    func now() -> Date
}

class ClockDefault: Clock {
    
    func now() -> Date {
        return Date()
    }
}
