
import Foundation

class UserTimelineTopBarViewModel {
    
    let initials: String
    let name: String
    let username: String
    
    convenience init(user: User) {
        
        let initials = (user.givenName.prefix(1) + user.familyName.prefix(1)).uppercased()
        let name = user.givenName + " " + user.familyName
        let username = "@" + user.username
        
        self.init(initials: initials, name: name, username: username)
    }
    
    private init(initials: String, name: String, username: String) {
        
        self.initials = initials
        self.name = name
        self.username = username
    }
    
    static var empty: UserTimelineTopBarViewModel {
        return UserTimelineTopBarViewModel(initials: "", name: "", username: "")
    }
}
