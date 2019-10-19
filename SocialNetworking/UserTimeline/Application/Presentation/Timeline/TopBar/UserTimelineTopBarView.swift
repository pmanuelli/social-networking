
import UIKit
import UIKitExtensions

@IBDesignable
class UserTimelineTopBarView: UIView {
    
    @IBOutlet var initialsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ViewContentLoader.loadContent(for: self)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        ViewContentLoader.loadContent(for: self)
    }
}
