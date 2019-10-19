
import Foundation

class UserTimelineTopBarViewModel {
    
    let initials: String
    let name: String
    let username: String
    
    init(user: User) {
        
        initials = (user.givenName.prefix(1) + user.familyName.prefix(1)).uppercased()
        name = user.givenName + " " + user.familyName
        username = "@" + user.username
    }
}
