import Combine

public extension Publisher {
    static func createFailure<T, E: Error>(failure: E) -> AnyPublisher<T, E> {
        Fail(outputType: T.self, failure: failure).eraseToAnyPublisher()
    }
}
