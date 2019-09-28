
@testable import SocialNetworking

import Foundation

class PostBuilder {
    
    func build() -> Post {
        return Post(id: UUID(), userId: UUID(), text: "Post text", date: Date())
    }
}
