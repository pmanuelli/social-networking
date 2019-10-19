
import Foundation

class PostTimeDescription {
    
    static func description(for postDate: Date, since now: Date = Date()) -> String {
        
        let difference = now.timeIntervalSince(postDate)
        
        let minuteInSeconds: Double = 60
        let hourInSeconds: Double = minuteInSeconds * 60
        let dayInSeconds: Double = hourInSeconds * 24
        
        switch difference {
        case ..<minuteInSeconds:
            return "\(Int(difference))s"
        case ..<hourInSeconds:
            return "\(Int(difference / minuteInSeconds))m"
        case ..<dayInSeconds:
            return "\(Int(difference / hourInSeconds))h"
        default:
            return "\(Int(difference / dayInSeconds))d"
        }
    }
}
