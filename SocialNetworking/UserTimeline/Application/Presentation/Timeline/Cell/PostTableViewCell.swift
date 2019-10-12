
import UIKit

class PostTableViewCell: UITableViewCell {

    static var identifier: String { return String(describing: self) }
    static var nib: UINib { return UINib(nibName: PostTableViewCell.identifier, bundle: nil) }
    
    var viewModel: PostCellViewModel? {
        didSet { bindViewModel() }
    }
    
    @IBOutlet private var postAuthorNameLabel: UILabel!
    @IBOutlet private var postTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        bindViewModel(viewModel)
    }
    
    private func bindViewModel(_ viewModel: PostCellViewModel) {
        
        postAuthorNameLabel.text = viewModel.authorName
        postTextLabel.text = viewModel.text
    }
}
