import Combine

public extension Publisher {
    static func createJust<T, E: Error>(value: T) -> AnyPublisher<T, E> {
        Just(value)
            .setFailureType(to: E.self)
            .eraseToAnyPublisher()
    }

    static func createJustNoCompletion<T, E: Error>(value: T) -> AnyPublisher<T, E> {
        Just(value)
            .setFailureType(to: E.self)
            .ignoreCompletion(.finished)
            .eraseToAnyPublisher()
    }
}

public extension Publisher where Output == Void {
    static func createJust<E: Error>() -> AnyPublisher<Output, E> {
        Just(()).setFailureType(to: E.self).eraseToAnyPublisher()
    }

    static func createJustNoCompletion<E: Error>() -> AnyPublisher<Output, E> {
        Just(())
            .setFailureType(to: E.self)
            .ignoreCompletion(.finished)
            .eraseToAnyPublisher()
    }
}
