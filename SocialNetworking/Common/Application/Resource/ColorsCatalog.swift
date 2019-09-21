
import UIKit

class ColorsCatalog {
    
    static var belowLevelBackground: UIColor { return UIColor(named: "Below Level Background")! }
    static var belowLevelFontTitle: UIColor { return UIColor(named: "Below Level Font Title")! }
    static var belowLevelFontBody: UIColor { return UIColor(named: "Below Level Font Body")! }

    static var atLevelBackground: UIColor { return UIColor(named: "At Level Background")! }
    static var atLevelFontTitle: UIColor { return UIColor(named: "At Level Font Title")! }
    static var atLevelFontBody: UIColor { return UIColor(named: "At Level Font Body")! }

    static var aboveLevelBackground: UIColor { return UIColor(named: "Above Level Background")! }
    static var aboveLevelFont: UIColor { return UIColor(named: "Above Level Font")! }
    static var aboveLevellFontBody: UIColor { return UIColor(named: "Above Level Font Body")! }
    
    // Can't use named colors with @IBDesignable
    
    static var primary: UIColor { return UIColor(red: 0.290, green: 0.612, blue: 0.996, alpha: 1) }
    static var secondary: UIColor { return UIColor(red: 0.255, green: 0.929, blue: 0.780, alpha: 1) }
}
