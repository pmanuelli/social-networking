
import Foundation

struct Post {
    
    let id: UUID
    let userId: UUID
    let text: String
    let date: Date
}

extension Post: Equatable { }
