import Combine

public extension Publisher {
    func toOptional() -> Publishers.Map<Self, Optional<Self.Output>> {
        map { $0 }
    }
}
