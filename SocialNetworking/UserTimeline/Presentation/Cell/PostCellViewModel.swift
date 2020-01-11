
import Foundation

struct PostCellViewModel {
    
    let authorInitials: String
    let authorName: String
    let authorUsername: String
    let body: String
    let time: String
    
    init(post: Post, author: User) {
        
        authorInitials = (author.givenName.prefix(1) + author.familyName.prefix(1)).uppercased()
        authorName = author.givenName + " " + author.familyName
        authorUsername = "@" + author.username
        body = post.text
        time = PostTimeDescription.description(for: post.date)
    }
}
