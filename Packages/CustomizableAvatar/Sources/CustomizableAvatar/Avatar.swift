#if os(iOS)
    import UIKit
#elseif os(macOS)
    import Cocoa
#endif

public enum AvatarViewCornerStyle {
    case rounded(Double)
    case circular
    case flat
}

public struct SolidColorConstructorConfiguration {
    public let fontSize: Double
    public let fontName: String
    public let backgroundColor: Hex
    public let textColor: Hex
    public let name: String

    public init(fontSize: Double, fontName: String, backgroundColor: Hex, textColor: Hex, name: String) {
        self.fontSize = fontSize
        self.fontName = fontName
        self.backgroundColor = backgroundColor
        self.textColor = textColor
        self.name = name
    }
}

public struct GradientColorConstructorConfiguration {
    public let fontSize: Double
    public let fontName: String
    public let startColor: Hex
    public let endColor: Hex
    public let textColor: Hex
    public let name: String

    public init(fontSize: Double, fontName: String, startColor: Hex, endColor: Hex, textColor: Hex, name: String) {
        self.fontSize = fontSize
        self.fontName = fontName
        self.startColor = startColor
        self.endColor = endColor
        self.textColor = textColor
        self.name = name
    }
}

public enum AvatarSource {
    case gradientColor(GradientColorConstructorConfiguration)
    case solidColor(SolidColorConstructorConfiguration)
#if os(iOS)
    case image(UIImage)
#elseif os(macOS)
    case image(NSImage)
#endif
}

#if os(iOS)


public final class Avatar: UIView {

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        addSubview(imageView)

        imageView.isHidden = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        return imageView
    }()

    private lazy var gradientView: UIView = {
        let view = UIView()
        addSubview(view)

        view.isHidden = true
        view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor),
            view.bottomAnchor.constraint(equalTo: bottomAnchor),
            view.leadingAnchor.constraint(equalTo: leadingAnchor),
            view.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])

        return view
    }()

    private lazy var initialsLabel: UILabel = {
        let label = UILabel()
        addSubview(label)

        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.minimumScaleFactor = 0.5
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor, constant: 16.0),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16.0),
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16.0),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16.0)
        ])

        return label
    }()

    public var cornerStyle: AvatarViewCornerStyle = .circular {
        didSet {
            setupView()
        }
    }

    private var gradientColor: [UIColor]?

    public struct AvatarConfiguration {
        public let cornerStyle: AvatarViewCornerStyle
        public let source: AvatarSource

        public init(cornerStyle: AvatarViewCornerStyle, source: AvatarSource) {
            self.cornerStyle = cornerStyle
            self.source = source
        }
    }

    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    public override func layoutSubviews() {
        super.layoutSubviews()
        setupView()
    }

    private func setupView() {
        configureCornerStyle()
        if let gradientColor {
            gradientView.layer.sublayers?.removeAll()
            gradientView.applyLinearGradient(colors: gradientColor)
        }
    }

    private func configureCornerStyle() {
        layer.masksToBounds = true
        switch cornerStyle {
        case .rounded(let radius):
            layer.cornerRadius = radius
        case .circular:
            layer.cornerRadius = bounds.width / 2
        case .flat:
            layer.cornerRadius = 0.0
        }
    }

    public func apply(_ configuration: AvatarConfiguration) {
        switch configuration.source {
        case .gradientColor(let configuration):
            initialsLabel.apply(configuration)
            initialsLabel.isHidden = false
            imageView.isHidden = true
            gradientView.isHidden = false
            gradientColor = [
                UIColor(hex: configuration.startColor),
                UIColor(hex: configuration.endColor)
            ]
        case .solidColor(let configuration):
            initialsLabel.apply(configuration)
            initialsLabel.isHidden = false
            imageView.isHidden = true
            gradientView.isHidden = true
            backgroundColor = UIColor(hex: configuration.backgroundColor)
        case .image(let image):
            imageView.image = image
            imageView.isHidden = false
            initialsLabel.isHidden = true
            gradientView.isHidden = true
        }
        bringSubviewToFront(initialsLabel)
        cornerStyle = configuration.cornerStyle
    }
}

fileprivate extension UILabel {
    func apply(_ configuration: SolidColorConstructorConfiguration) {
        font = UIFont(name: configuration.fontName, size: configuration.fontSize)
        minimumScaleFactor = 0.5
        let composedText = configuration.name
            .split(separator: " ")
            .compactMap { $0.first }
            .map { String($0) }
            .joined()
            .uppercased()

        text = composedText
        textColor = UIColor(hex: configuration.textColor)
    }

    func apply(_ configuration: GradientColorConstructorConfiguration) {
        font = UIFont(name: configuration.fontName, size: configuration.fontSize)
        minimumScaleFactor = 0.5
        let composedText = configuration.name
            .split(separator: " ")
            .compactMap { $0.first }
            .map { String($0) }
            .joined()
            .uppercased()

        text = composedText
        textColor = UIColor(hex: configuration.textColor)
    }
}

#endif
