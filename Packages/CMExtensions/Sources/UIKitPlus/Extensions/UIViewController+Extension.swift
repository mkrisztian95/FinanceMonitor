import UIKit

public extension UIViewController {
    var topestController: UIViewController {
        var topestController: UIViewController = self
        var next: UIViewController?
        repeat {
            if let topestController = topestController as? UINavigationController {
                next = topestController.visibleViewController
            } else {
                next = topestController.presentedViewController
            }
            if let next {
                topestController = next
            }
        } while next != nil

        return topestController
    }

    func childViewControllersCount(where condition: (UIViewController) -> Bool) -> Int {
        var count = 0
        var topestController: UIViewController = self
        var next: UIViewController?
        repeat {
            if let topestController = topestController as? UINavigationController {
                next = topestController.visibleViewController
            } else {
                next = topestController.presentedViewController
            }
            if let next {
                if condition(next) {
                    count += 1
                }
                topestController = next
            }
        } while next != nil

        return count
    }
}
