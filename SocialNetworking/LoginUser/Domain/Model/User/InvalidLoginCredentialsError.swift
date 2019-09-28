
import Foundation

class InvalidLoginCredentialsError: LocalizedError {

    let errorDescription: String?
    
    init(username: String) {
        errorDescription = "Username '\(username)' is not registered or password is incorrect!"
    }
}
