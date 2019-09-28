
import Foundation

//sourcery: AutoMockable
protocol LanguageService {
    
    func isInappropriate(_ text: String) -> Bool
}

class LanguageServiceDefault: LanguageService {
    
    func isInappropriate(_ text: String) -> Bool {
        abort()
    }
}
