import Combine
import UIKit

private var longTapGesturePublishers: [UIView: PassthroughSubject<UIGestureRecognizer.State, Never>] = [:]

public extension UIView {
    var tapGesturePublisher: AnyPublisher<UITapGestureRecognizer, Never> {
        let tapGesture = UITapGestureRecognizer()
        isUserInteractionEnabled = true
        addGestureRecognizer(tapGesture)
        return tapGesture.tapPublisher
    }

    var longTapGestureState: AnyPublisher<UIGestureRecognizer.State, Never> {
        if longTapGesturePublishers[self] == nil {
            let tapGesture = UILongPressGestureRecognizer(
                target: self,
                action: #selector(handleLongPress)
            )
            isUserInteractionEnabled = true
            addGestureRecognizer(tapGesture)
            tapGesture.delegate = self
            let publisher = PassthroughSubject<UIGestureRecognizer.State, Never>()
            longTapGesturePublishers[self] = publisher
        }
        return longTapGesturePublishers[self]!.eraseToAnyPublisher()
    }

    var bottomSwipeGesturePublisher: AnyPublisher<UISwipeGestureRecognizer, Never> {
        let swipeGesture = UISwipeGestureRecognizer()
        swipeGesture.direction = .down
        isUserInteractionEnabled = true
        addGestureRecognizer(swipeGesture)
        return swipeGesture.swipePublisher
    }
}

extension UIView: UIGestureRecognizerDelegate {
    @objc final func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
        longTapGesturePublishers[self]?.send(gestureReconizer.state)
    }
}
