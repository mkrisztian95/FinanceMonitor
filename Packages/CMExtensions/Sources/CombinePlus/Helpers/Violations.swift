extension Subscribers.Demand {
    func assertNonZero(
        file: StaticString = #file,
        line: UInt = #line
    ) {
        if self == .none {
            fatalError("API Violation: demand must not be zero", file: file, line: line)
        }
    }
}
