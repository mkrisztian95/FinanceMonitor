fileprivate extension String {
    var rgb: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        var hexSanitized = trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        return (red: red, green: green, blue: blue)
    }
}

fileprivate extension Array where Element == CGFloat {
    func toHex(with alpha: Bool) -> String {
        let r = Float(self[0])
        let g = Float(self[1])
        let b = Float(self[2])
        var a = Float(self[3])

        if alpha {
            a = a * 255.0
            return String(format: "#%02X%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255), Int(a))
        } else {
            return String(format: "#%02X%02X%02X", Int(r * 255), Int(g * 255), Int(b * 255))
        }
    }
}

public typealias Hex = String

#if os(iOS)
import UIKit

public extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let rgb = hex.rgb

        self.init(
            red: rgb.red,
            green: rgb.green,
            blue: rgb.blue,
            alpha: alpha
        )
    }

    func toHex(alpha: Bool = false) -> String {
        guard let components = self.cgColor.components else {
            fatalError("Invalid color")
        }

        return components.toHex(with: alpha)
    }
}
#elseif os(macOS)
import Cocoa

extension NSColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        let rgb = hex.rgb
        
        self.init(
            red: rgb.red,
            green: rgb.green,
            blue: rgb.blue,
            alpha: alpha
        )
    }

    func toHex(alpha: Bool = false) -> String {
        guard let components = self.cgColor?.components else {
            fatalError("Invalid color")
        }

        return components.toHex(with: alpha)
    }
}
#endif

