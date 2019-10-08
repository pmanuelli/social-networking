
@testable import SocialNetworking

import Foundation

class PostBuilder {
    
    private var userId = UUID()
    private var date = Date()
    
    func withUserId(_ userId: UUID) -> PostBuilder {
        self.userId = userId
        return self
    }
    
    func withDate(_ date: Date) -> PostBuilder {
        self.date = date
        return self
    }
    
    func build() -> Post {
        return Post(id: UUID(), userId: userId, text: "Post text", date: date)
    }
}
