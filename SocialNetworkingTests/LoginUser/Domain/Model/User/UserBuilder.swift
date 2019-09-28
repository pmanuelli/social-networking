
@testable import SocialNetworking

import Foundation

class UserBuilder {
    
    private var id = UUID()
    private var username = "mjkeenan"
    private var password = "password"
    
    func withId(_ id: UUID) -> UserBuilder {
        self.id = id
        return self
    }
    
    func withUsername(_ username: String) -> UserBuilder {
        self.username = username
        return self
    }
    
    func withPassword(_ password: String) -> UserBuilder {
        self.password = password
        return self
    }
    
    func build() -> User {
        
        return User(id: id,
                    username: username, password: password,
                    givenName: "Maynard James", familyName: "Keenan")
    }
}
