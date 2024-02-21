import UIKit

public extension UIButton {

    var title: String? {
        get {
            title(for: .normal)
        }
        set {
            setTitle(newValue)
        }
    }

    func setTitleColor(_ color: UIColor?) {
        setTitleColor(color, for: .normal)
    }

    func setTitle(_ title: String?) {
        setTitle(title, for: .normal)
    }

    func setImage(_ image: UIImage?) {
        setImage(image, for: .normal)
    }

    var imageEdgeInsetsIgnoreDeprecated: UIEdgeInsets {
        get {
            value(forKey: "imageEdgeInsets") as! UIEdgeInsets
        }
        set {
            setValue(newValue, forKey: "imageEdgeInsets")
        }
    }

    @available(iOS 14.0, *)
    func addAction(_ action: @escaping () -> Void, for event: UIControl.Event = .touchUpInside) {
        addAction(UIAction { _ in action() }, for: event)
    }
}
