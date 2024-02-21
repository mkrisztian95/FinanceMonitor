import Combine

public extension Publishers {

    enum Completion {
        case finished
        case failure
    }

    final class IgnoreCompletion<Upstream: Publisher>: Publisher {

        public typealias Output = Upstream.Output
        public typealias Failure = Upstream.Failure

        private let upstream: Upstream
        private let completions: [Publishers.Completion]

        init(upstream: Upstream, completions: [Publishers.Completion]) {
            self.upstream = upstream
            self.completions = completions
        }

        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {

            let subscriber = IgnoreCompletionSubscriber(
                completions: completions,
                downstream: subscriber
            )
            upstream.subscribe(subscriber)
        }
    }
}

private extension Publishers.IgnoreCompletion {

    struct IgnoreCompletionSubscriber<S>: Subscriber where S: Subscriber, S.Input == Output, S.Failure == Failure {

        typealias Input = S.Input
        typealias Failure = S.Failure

        let completions: [Publishers.Completion]
        let downstream: S

        let combineIdentifier = CombineIdentifier()

        func receive(subscription: Subscription) {
            downstream.receive(subscription: subscription)
        }

        func receive(_ input: S.Input) -> Subscribers.Demand {
            downstream.receive(input)
        }

        func receive(completion: Subscribers.Completion<S.Failure>) {
            switch completion {
            case .finished:
                if !completions.contains(.finished) {
                    downstream.receive(completion: completion)
                }
            case .failure:
                if !completions.contains(.failure) {
                    downstream.receive(completion: completion)
                }
            }
        }
    }
}

public extension Publisher {

    func ignoreCompletion(
        _ completions: Publishers.Completion...
    ) -> Publishers.IgnoreCompletion<Self> {
        Publishers.IgnoreCompletion(upstream: self, completions: completions)
    }
}
