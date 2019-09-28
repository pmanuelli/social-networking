
import Foundation

//sourcery: AutoMockable
protocol IdGenerator {
    
    func next() -> UUID
}

class IdGeneratorDefault: IdGenerator {
    
    func next() -> UUID {
        return UUID()
    }
}
