
import Foundation

struct User {
    
    let id: UserId
    let username: String
    let password: String
    let givenName: String
    let familyName: String
}

extension User: Equatable { }
