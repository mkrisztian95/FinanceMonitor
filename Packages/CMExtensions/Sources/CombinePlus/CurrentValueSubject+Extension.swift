import Combine

public extension CurrentValueSubject {
    func finish(_ input: Output) {
        send(input)
        send(completion: .finished)
    }
}
