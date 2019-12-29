
import Foundation

struct Post {
    
    let id: PostId
    let userId: UserId
    let text: String
    let date: Date
}

extension Post: Equatable { }
