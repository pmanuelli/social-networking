
@testable import SocialNetworking

import Foundation

class PostBuilder {
    
    private var userId = UserId(raw: UUID())
    private var date = Date()
    
    func withUserId(_ userId: UserId) -> PostBuilder {
        self.userId = userId
        return self
    }
    
    func withDate(_ date: Date) -> PostBuilder {
        self.date = date
        return self
    }
    
    func build() -> Post {
        return Post(id: PostId(raw: UUID()), userId: userId, text: "Post text", date: date)
    }
}
