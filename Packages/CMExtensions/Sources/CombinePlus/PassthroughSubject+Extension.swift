import Combine

public extension PassthroughSubject {
    func finish(_ input: Output) {
        send(input)
        send(completion: .finished)
    }

    func fail(_ failure: Failure) {
        send(completion: .failure(failure))
    }
}

public extension PassthroughSubject where Output == Void {
    func finish() {
        send(())
        send(completion: .finished)
    }
}
