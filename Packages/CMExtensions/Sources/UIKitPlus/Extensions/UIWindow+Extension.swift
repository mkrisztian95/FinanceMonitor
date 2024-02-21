import UIKit

public extension UIWindow {
    static var safeAreaHeight: (top: CGFloat, bottom: CGFloat)? {
        guard let window = UIApplication.keyWindow else { return nil }
        return (top: window.safeAreaInsets.top, bottom: window.safeAreaInsets.bottom)
    }
}
