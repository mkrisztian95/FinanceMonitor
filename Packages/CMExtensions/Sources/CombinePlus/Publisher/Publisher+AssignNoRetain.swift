import Combine

public extension Publisher where Self.Failure == Never {

    /// Republishes elements received from a publisher, by assigning them to a property.
    /// Hold WEAK reference to object
    func assignNoRetain<Root>(
        to keyPath: ReferenceWritableKeyPath<Root, Self.Output>,
        on object: Root
    ) -> AnyCancellable where Root: AnyObject {
        sink { [weak object] value in
            object?[keyPath: keyPath] = value
        }
    }
}
