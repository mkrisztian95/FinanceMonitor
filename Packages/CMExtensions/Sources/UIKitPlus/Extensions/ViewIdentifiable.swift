import UIKit

public protocol ViewIdentifiable { }

public extension ViewIdentifiable {
    var string: String {
        String(reflecting: self).split(separator: ".").dropFirst().joined(separator: ".")
    }
}

public extension UIView {

    var viewID: ViewIdentifiable {
        @available(*, unavailable)
        get {
            fatalError("This is set only property")
        }
        set {
            accessibilityIdentifier = newValue.string
        }
    }

    func withViewID(_ viewID: ViewIdentifiable) -> Self {
        self.viewID = viewID
        return self
    }
}

public extension UIBarButtonItem {
    var viewID: ViewIdentifiable {
        @available(*, unavailable)
        get {
            fatalError("This is set only property")
        }
        set {
            accessibilityIdentifier = newValue.string
        }
    }
}
