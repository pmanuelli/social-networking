
import UIKit

class PostTableViewCell: UITableViewCell {

    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: PostTableViewCell.identifier, bundle: nil) }
    
    var viewModel: PostCellViewModel? {
        didSet { bindViewModel() }
    }
    
    @IBOutlet private var authorInitialsLabel: UILabel!
    @IBOutlet private var authorNameLabel: UILabel!
    @IBOutlet private var authorUsernameLabel: UILabel!
    @IBOutlet private var timeLabel: UILabel!
    @IBOutlet private var bodyLabel: UILabel!
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        bindViewModel(viewModel)
    }
    
    private func bindViewModel(_ viewModel: PostCellViewModel) {
        
        authorInitialsLabel.text = viewModel.authorInitials
        authorNameLabel.text = viewModel.authorName
        authorUsernameLabel.text = viewModel.authorUsername
        timeLabel.text = viewModel.time
        bodyLabel.text = viewModel.body
    }
}
