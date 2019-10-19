
import UIKit
import UIKitExtensions

@IBDesignable
class UserTimelineTopBarView: UIView {
    
    @IBOutlet private var initialsLabel: UILabel!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var usernameLabel: UILabel!
    
    @IBOutlet var logoutButton: UIButton!
    
    var viewModel: UserTimelineTopBarViewModel? { didSet { bindViewModel() } }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        ViewContentLoader.loadContent(for: self)
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        ViewContentLoader.loadContent(for: self)
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        
        bindViewModel(viewModel)
    }
    
    private func bindViewModel(_ viewModel: UserTimelineTopBarViewModel) {
        
        initialsLabel.text = viewModel.initials
        nameLabel.text = viewModel.name
        usernameLabel.text = viewModel.username
    }
}
