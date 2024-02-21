import Combine
import UIKit

public class ApplicationLifecycleService {

    public init() { }

    public var didBecomeActivePublisher: AnyPublisher<Void, Never> {
        NotificationCenter
            .default
            .publisher(for: UIApplication.didBecomeActiveNotification)
            .map { _ in }
            .eraseToAnyPublisher()
    }

    public var didEnterBackgroundPublisher: AnyPublisher<Void, Never> {
        NotificationCenter
            .default
            .publisher(for: UIApplication.didEnterBackgroundNotification)
            .map { _ in }
            .eraseToAnyPublisher()
    }

    public var didFinishLaunchingPublisher: AnyPublisher<Void, Never> {
        NotificationCenter
            .default
            .publisher(for: UIApplication.didFinishLaunchingNotification)
            .map { _ in }
            .eraseToAnyPublisher()
    }

    public var willEnterForegroundPublisher: AnyPublisher<Void, Never> {
        NotificationCenter
            .default
            .publisher(for: UIApplication.willEnterForegroundNotification)
            .map { _ in }
            .eraseToAnyPublisher()
    }

    public var willResignActivePublisher: AnyPublisher<Void, Never> {
        NotificationCenter
            .default
            .publisher(for: UIApplication.willResignActiveNotification)
            .map { _ in }
            .eraseToAnyPublisher()
    }

    public var willTerminatePublisher: AnyPublisher<Void, Never> {
        NotificationCenter
            .default
            .publisher(for: UIApplication.willTerminateNotification)
            .map { _ in }
            .eraseToAnyPublisher()
    }
}
