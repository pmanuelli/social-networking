
import Foundation

class UsernameAlreadyInUseError: LocalizedError {

    let errorDescription: String?
    
    init(username: String) {
        errorDescription = "Username '\(username)' is already in use!"
    }
}
