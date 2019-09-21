
import UIKit
import UIKitExtensions

@IBDesignable
class PrimaryButton: UIButton {
        
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
    }
    
    private func insertBackgroundView() {
        insertSubviewToBounds(createBackgroundView(), at: 0)
    }

    private func createBackgroundView() -> UIView {
                
        return GradientView(colorLocations: createGradientColorLocations(),
                            startPoint: CGPoint(x: 0, y: 0.5),
                            endPoint: CGPoint(x: 1, y: 0.5))
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
}
