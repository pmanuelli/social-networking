
import Foundation

//sourcery: AutoMockable
protocol PostIdGenerator {
    
    func next() -> PostId
}

class PostIdGeneratorDefault: PostIdGenerator {
    
    func next() -> PostId {
        return PostId(raw: UUID())
    }
}
