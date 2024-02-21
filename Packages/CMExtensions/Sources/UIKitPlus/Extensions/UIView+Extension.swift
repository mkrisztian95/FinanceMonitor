import UIKit

public extension UIView {

    class func animate(
        withDuration duration: TimeInterval,
        options: UIView.AnimationOptions = [],
        animations: @escaping () -> Void,
        completion: ((Bool) -> Void)? = nil
    ) {
        UIView.animate(
            withDuration: duration,
            delay: 0,
            options: options,
            animations: animations,
            completion: completion
        )
    }

    class func crossDissolve(
        with view: UIView,
        duration: TimeInterval = 0.3,
        animations: (() -> Void)?,
        completion: ((Bool) -> Void)? = nil
    ) {
        UIView.transition(
            with: view,
            duration: duration,
            options: [.transitionCrossDissolve, .allowUserInteraction, .beginFromCurrentState],
            animations: animations,
            completion: completion
        )
    }

    var isVisible: Bool {
        get {
            !isHidden
        }
        set {
            isHidden = !newValue
        }
    }

    func setHidden(
        _ hidden: Bool,
        withDuration duration: Double = 0.3,
        delay: TimeInterval = 0,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard hidden != isHidden else {
            completion?(true)
            return
        }

        if !hidden {
            isHidden = false
        }

        if duration == .zero {
            alpha = hidden ? 0 : 1
            if hidden {
                isHidden = true
            }
            completion?(true)
        } else {
            UIView.animate(withDuration: duration, delay: delay) {
                self.alpha = hidden ? 0 : 1
            } completion: { completed in
                if hidden {
                    self.isHidden = true
                }
                completion?(completed)
            }
        }
    }

    enum FlipOtions {
        case `default`
        case custom(AnimationOptions)
    }

    func flip(
        toHidden hidden: Bool,
        duration: Double = 0.5,
        options: FlipOtions = .default,
        completion: ((Bool) -> Void)? = nil
    ) {
        guard hidden != isHidden else {
            completion?(true)
            return
        }

        let animationOptions: AnimationOptions = {
            if case let .custom(animationOptions) = options {
                return animationOptions
            }
            return [.curveEaseOut, hidden ? .transitionFlipFromTop : .transitionFlipFromBottom]
        }()

        UIView.transition(
            with: self,
            duration: duration,
            options: animationOptions
        ) {
            if !hidden {
                self.isHidden = hidden
            } else {
                self.layer.opacity = 0
            }
        } completion: { completed in
            if hidden {
                self.isHidden = hidden
                self.layer.opacity = 1
            }
            completion?(completed)
        }
    }

    func firstSuperview(where condition: (UIView) -> Bool) -> UIView? {
        guard var view = superview else { return nil }
        while !condition(view) {
            guard let superview = view.superview else { return nil }
            view = superview
        }
        return view
    }

    func screenshot(maskView: UIView) -> UIImage {
        screenshot(maskFrame: maskView.frame)
    }

    func screenshot(maskFrame: CGRect) -> UIImage {
        UIGraphicsBeginImageContext(maskFrame.size)

        if let context = UIGraphicsGetCurrentContext() {
            context.translateBy(
                x: frame.minX - maskFrame.minX,
                y: frame.minY - maskFrame.minY
            )
            layer.render(in: context)
        }

        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()

        return image ?? .init()
    }

    var absoluteCenter: CGPoint {
        if let superview = superview {
            superview.convert(center, to: nil)
        } else {
            center
        }
    }

    /// If ViewState is present, performs the `apply` method and sets `isHidden` as true. Otherwise, sets `isHidden` as false
    func applyIfPresent<ViewState>(
        _ viewState: ViewState?,
        apply: (ViewState) -> Void
    ) {
        if let viewState {
            apply(viewState)
            isHidden = false
        } else {
            isHidden = true
        }
    }

    func addSubviews(_ subviews: [UIView]) {
        subviews.forEach {
            addSubview($0)
        }
    }

    func addSubviews(_ subviews: UIView...) {
        subviews.forEach {
            addSubview($0)
        }
    }

    @discardableResult
    func preparedForAutoLayout() -> Self {
        translatesAutoresizingMaskIntoConstraints = false
        return self
    }

    @discardableResult
    func fixedHeight(_ height: CGFloat) -> Self {
        heightAnchor.constraint(equalToConstant: height).isActive = true
        return self
    }

    @discardableResult
    func fixedHeight(_ dimension: NSLayoutDimension, constant: CGFloat = .zero) -> Self {
        heightAnchor.constraint(equalTo: dimension, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func fixedWidth(_ width: CGFloat) -> Self {
        widthAnchor.constraint(equalToConstant: width).isActive = true
        return self
    }

    @discardableResult
    func fixedWidth(_ dimension: NSLayoutDimension, constant: CGFloat = .zero) -> Self {
        widthAnchor.constraint(equalTo: dimension, constant: constant).isActive = true
        return self
    }

    @discardableResult
    func fixedSize(_ size: CGSize) -> Self {
        fixedWidth(size.width).fixedHeight(size.height)
    }
}
