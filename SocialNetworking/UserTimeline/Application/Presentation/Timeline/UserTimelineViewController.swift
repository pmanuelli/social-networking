
import UIKit
import UIKitExtensions
import RxSwift
import RxCocoa

class UserTimelineViewController: UIViewController {
    
    private let viewModel: UserTimelineViewModel
    private lazy var mainView = UserTimelineView.initFromNib()
    
    private let disposeBag = DisposeBag()
    
    init(viewModel: UserTimelineViewModel) {
        self.viewModel = viewModel
        super.init(nibName: .none, bundle: .none)
    }
    
    required init?(coder aDecoder: NSCoder) { return nil }
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }

    private func bindViewModel() {

        bindPublishButton()
        bindErrorDescriptionLabel()
    }
        
    private func bindPublishButton() {
        
        mainView.publishButton.addTarget(self, action: #selector(publishButtonTouched), for: .touchUpInside)
    }
        
    @objc
    private func publishButtonTouched() {
        viewModel.publishButtonTouched(postText: mainView.postTextView.text)
    }
    
    private func bindErrorDescriptionLabel() {
        
        viewModel.output.publishErrorDescription
            .drive(onNext: { [weak self] in self?.errorDescriptionDidChange($0) })
            .disposed(by: disposeBag)
    }
    
    private func errorDescriptionDidChange(_ description: String) {
        
        if description.isEmpty {
            mainView.hideErrorLabel()
        }
        else {
            mainView.showErrorLabel(description)
        }
    }
}
