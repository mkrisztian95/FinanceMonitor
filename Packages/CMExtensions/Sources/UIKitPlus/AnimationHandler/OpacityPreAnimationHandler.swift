public class OpacityPreAnimationHandler: AnimationHandler {

    private let duration: Double
    private let delay: TimeInterval

    public init(duration: Double, delay: TimeInterval) {
        self.duration = duration
        self.delay = delay
    }

    public func animate(view: UIView, completion: ((Bool) -> Void)?) {
        view.setHidden(true, withDuration: duration, delay: delay, completion: completion)
    }
}

public extension AnimationHandler where Self == OpacityPreAnimationHandler {

    static var defaultPreAnimationHandler: Self {
        OpacityPreAnimationHandler(duration: 0, delay: 0)
    }
}
