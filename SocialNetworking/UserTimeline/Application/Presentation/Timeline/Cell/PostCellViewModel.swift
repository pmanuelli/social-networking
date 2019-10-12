
import Foundation

struct PostCellViewModel {
    
    let authorName: String
    let text: String
    
    init(post: Post) {
        
        authorName = String("\(post.userId)".prefix(2))
        text = post.text
    }
}
