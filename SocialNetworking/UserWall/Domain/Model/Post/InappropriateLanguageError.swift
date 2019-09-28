
import Foundation

class InappropriateLanguageError: LocalizedError {

    let errorDescription: String?
    
    init() {
        errorDescription = "Post contains inappropriate language."
    }
}
