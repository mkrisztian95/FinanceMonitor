import UIKit

public protocol AnimationHandler {

    func animate(view: UIView, completion: ((Bool) -> Void)?)
}
