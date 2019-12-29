
import Foundation

struct Post {
    
    let id: UUID
    let userId: UserId
    let text: String
    let date: Date
}

extension Post: Equatable { }
