
import Foundation

//sourcery: AutoMockable
protocol UserIdGenerator {
    
    func next() -> UserId
}

class UserIdGeneratorDefault: UserIdGenerator {
    
    func next() -> UserId {
        return UserId(raw: UUID())
    }
}
