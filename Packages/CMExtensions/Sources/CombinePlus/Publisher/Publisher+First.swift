public extension Publisher {

    func first(complete: Bool = true) -> AnyPublisher<Output, Failure> {
        if complete {
            first()
                .eraseToAnyPublisher()
        } else {
            first()
                .ignoreCompletion(.finished)
                .eraseToAnyPublisher()
        }
    }
}
