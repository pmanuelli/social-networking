
import UIKit
import UIKitExtensions

@IBDesignable
class PrimaryButton: UIButton {
    
    override var isEnabled: Bool {
        didSet { updateEnabledDesign() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        postInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        postInit()
    }
    
    private func postInit() {
        insertBackgroundView()
        updateEnabledDesign()
    }
    
    private func insertBackgroundView() {
        insertSubviewToBounds(createBackgroundView(), at: 0)
    }

    private func createBackgroundView() -> UIView {
                
        let view = GradientView(colorLocations: createGradientColorLocations(),
                                startPoint: CGPoint(x: 0, y: 0.5),
                                endPoint: CGPoint(x: 1, y: 0.5))
        
        view.isUserInteractionEnabled = false
        
        return view
    }
    
    private func createGradientColorLocations() -> [GradientView.ColorLocation] {
        
        return [GradientView.ColorLocation(color: ColorsCatalog.primary, location: 0),
                GradientView.ColorLocation(color: ColorsCatalog.secondary, location: 1)]
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    private func updateCornerRadius() {
        
        cornerRadius = bounds.height / CGFloat(2)
        clipsToBounds = true
    }
    
    private func updateEnabledDesign() {
        alpha = isEnabled ? 1 : 0.25
    }
}
