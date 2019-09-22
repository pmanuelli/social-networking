
import Foundation

struct User {
    
    let id: UUID
    let username: String
    let givenName: String
    let familyName: String
}

extension User: Equatable { }
