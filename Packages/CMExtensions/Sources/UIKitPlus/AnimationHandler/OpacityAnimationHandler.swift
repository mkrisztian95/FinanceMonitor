public class OpacityAnimationHandler: AnimationHandler {

    private let duration: Double
    private let delay: TimeInterval

    public init(duration: Double, delay: TimeInterval) {
        self.duration = duration
        self.delay = delay
    }

    public func animate(view: UIView, completion: ((Bool) -> Void)?) {
        view.setHidden(false, withDuration: duration, delay: delay, completion: completion)
    }
}

public extension AnimationHandler where Self == OpacityAnimationHandler {

    static var defaultAnimationHandler: Self {
        OpacityAnimationHandler(duration: 0.5, delay: 0)
    }
}
