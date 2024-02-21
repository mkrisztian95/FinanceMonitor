#if os(iOS)
import UIKit

extension UIView {
    func applyLinearGradient(colors: [UIColor], startPoint: CGPoint = .zero, endPoint: CGPoint = .init(x: 1, y: 1)) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors.map { $0.cgColor }
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        gradientLayer.frame = bounds

        layer.insertSublayer(gradientLayer, at: 0)
    }
}

#elseif os(macOS)
import Cocoa

import Cocoa

extension NSView {
    func applyLinearGradient(colors: [NSColor], startPoint: NSPoint, endPoint: NSPoint) {
        let gradient = NSGradient(starting: colors.first ?? NSColor.clear, ending: colors.last ?? NSColor.clear)
        gradient?.draw(from: startPoint, to: endPoint, options: [])
    }
}

#endif



