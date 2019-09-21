
import Foundation

extension NSError {
    
    convenience init(domain: String, code: Int, localizedDescription: String) {
        
        self.init(domain: domain, code: code,
                  userInfo: [NSLocalizedDescriptionKey : localizedDescription])
    }
}
