import UIKit

public extension UIScrollView {

    /**
     Bounces the scroll view in the specified direction.

     - Parameter axis: The direction of the bounce animation, either horizontal or vertical.
     - Parameter offset: The offset for the bounce animation. Default is 30.0.
     - Parameter duration: The duration of the bounce animation. Default is 0.5 seconds.
     - Parameter delay: The delay before starting the bounce animation. Default is zero seconds.

     */
    func bounce(
        by axis: NSLayoutConstraint.Axis,
        with offset: CGFloat = 30.0,
        and duration: Double = 0.5,
        after delay: Double = .zero
    ) {

        let originalContentOffset = contentOffset
        let newContentOffset = switch axis {
        case .horizontal:
            CGPoint(x: originalContentOffset.x + offset, y: originalContentOffset.y)
        case .vertical:
            CGPoint(x: originalContentOffset.x, y: originalContentOffset.y + offset)
        @unknown default:
            CGPoint.zero
        }

        UIView.animateSteps { sequence in
            sequence.add(duration: duration) { [weak self] in
                self?.contentOffset = newContentOffset
            }
            .add(duration: duration) { [weak self] in
                self?.contentOffset = originalContentOffset
            }
        }
    }
}
