import UIKit

@resultBuilder
public struct ConstraintBuilder {
    public static func buildBlock(
        _ components: NSLayoutConstraint...
    ) -> [NSLayoutConstraint] {
        components
    }
}

public extension NSLayoutConstraint {
    static func activate(
        @ConstraintBuilder constraints: () -> [NSLayoutConstraint]
    ) {
        NSLayoutConstraint.activate(constraints())
    }
}
