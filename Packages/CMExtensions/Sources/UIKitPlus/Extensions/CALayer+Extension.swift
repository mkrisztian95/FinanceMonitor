import QuartzCore

public extension CALayer {
    func addSublayers(_ sublayers: [CALayer]) {
        sublayers.forEach { addSublayer($0) }
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

        if hidden {
            CATransaction.begin()
            CATransaction.setCompletionBlock { [weak self] in
                self?.isHidden = true
            }
        }

        let animation = CABasicAnimation(keyPath: #keyPath(CALayer.opacity))
        animation.fromValue = opacity
        animation.toValue = hidden ? 0 : 1
        animation.duration = duration
        opacity = hidden ? 0 : 1
        add(animation, forKey: "opacity")

        if hidden {
            CATransaction.commit()
        }
    }
}
