import Combine
import UIKit

public extension UITextField {

    /// A publisher that emits whenever the user taps out of the text fields and ends the editing.
    var didEndEditingPublisher: AnyPublisher<Void, Never> {
        controlEventPublisher(for: .editingDidEnd)
    }
}
