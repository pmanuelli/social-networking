
@testable import SocialNetworking

import Foundation

class UserCredentialsBuilder {
    
    func build() -> UserCredentials {
        return UserCredentials(username: "username", password: "password")
    }
}
