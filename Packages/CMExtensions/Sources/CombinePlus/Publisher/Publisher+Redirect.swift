import Combine

public extension Publisher {

    func redirect<S: Subject>(to subject: S) -> AnyCancellable where Output == S.Output, Failure == S.Failure  {
        sink { [weak subject] completion in
            subject?.send(completion: completion)
        } receiveValue: { [weak subject] output in
            subject?.send(output)
        }
    }

    func redirect<S: Subject>(to subject: S, storeIn bag: inout CancelBag) where Output == S.Output, Failure == S.Failure  {
        sink { [weak subject] completion in
            subject?.send(completion: completion)
        } receiveValue: { [weak subject] output in
            subject?.send(output)
        }
        .store(in: &bag)
    }
}

public extension Publisher where Failure == Never {

    func redirect<R: Relay>(to relay: R) -> AnyCancellable where Output == R.Output, R: AnyObject {
        sink { [weak relay] output in
            relay?.accept(output)
        }
    }

    func redirect<R: Relay>(to relay: R, storeIn bag: inout CancelBag) where Output == R.Output, R: AnyObject {
        sink { [weak relay] output in
            relay?.accept(output)
        }
        .store(in: &bag)
    }
}
