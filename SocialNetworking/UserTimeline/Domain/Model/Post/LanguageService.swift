
import Foundation

//sourcery: AutoMockable
protocol LanguageService {
    
    func isInappropriate(_ text: String) -> Bool
}

class LanguageServiceDefault: LanguageService {
    
    private let inappropriateWords = ["android", "google"]
    
    func isInappropriate(_ text: String) -> Bool {
        return text.lowercased().containsAny(inappropriateWords)
    }
}

extension String {
    
    func containsAny(_ collection: [String]) -> Bool {
        collection.contains { contains($0) }
    }
}
