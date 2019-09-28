
import Foundation

struct UserCredentials {
    
    let username: String
    let password: String
    
    func matches(for user: User) -> Bool {
        return username == user.username && password == user.password
    }
}

extension UserCredentials: Equatable { }
