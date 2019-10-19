
import UIKit

class UserTimelineView: UIView {
    
    @IBOutlet var topBar: UserTimelineTopBarView!
    
    @IBOutlet var postTableView: UITableView!
    
    @IBOutlet var createPostButton: UIButton!
    @IBOutlet var createPostButtonContainer: UIView!
    
    override func awakeFromNib() {
        
        postTableView.register(PostTableViewCell.nib, forCellReuseIdentifier: PostTableViewCell.identifier)
    }
}
