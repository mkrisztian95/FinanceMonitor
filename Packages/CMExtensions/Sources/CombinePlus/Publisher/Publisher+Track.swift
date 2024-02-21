import Combine

public extension Publisher {

    func onError(action: @escaping (Self.Failure) -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveCompletion: { completion in
            if case let .failure(error) = completion {
                action(error)
            }
        })
    }

    func track(action: @escaping (Self.Output) -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveOutput: action)
    }

    func perform(action: @escaping (Self.Output) -> Void) -> Publishers.HandleEvents<Self> {
        handleEvents(receiveOutput: action)
    }
}
