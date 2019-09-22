
@testable import SocialNetworking

import Foundation

class UserBuilder {
    
    private var username = "mjkeenan"
    
    func withUsername(_ username: String) -> UserBuilder {
        self.username = username
        return self
    }
            
    func build() -> User {
        return User(id: UUID(), username: username, givenName: "Maynard James", familyName: "Keenan")
    }
}
