
import UIKit

class UserTimelineView: UIView {
    
    @IBOutlet var logoutButton: UIButton!

    @IBOutlet var initialsLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    
    @IBOutlet var postTableView: UITableView!
    
    @IBOutlet var createPostButton: UIButton!
    @IBOutlet var createPostButtonContainer: UIView!
    
    override func awakeFromNib() {
        
        postTableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
}
