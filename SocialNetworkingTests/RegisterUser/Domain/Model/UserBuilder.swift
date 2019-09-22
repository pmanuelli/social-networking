
@testable import SocialNetworking

import Foundation

class UserBuilder {
            
    func build() -> User {
        return User(id: UUID(), username: "mjkeenan", givenName: "Maynard James", familyName: "Keenan")
    }
}
