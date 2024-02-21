import UIKit

public extension UIScreen {

    enum Size {
        case small
        case medium
        case big
    }

    var widthSize: Size {
        if bounds.width <= 320 {
            return .small
        }
        if bounds.width <= 393 {
            return .medium
        }
        return .big
    }

    var heightSize: Size {
        if bounds.height <= 736 {
            return .small
        }
        if bounds.height <= 852 {
            return .medium
        }
        return .big
    }
}
