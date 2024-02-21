
public protocol ConstructorToolbarProtocol {
    func didChangeSource(_ source: AvatarSource)
    func didTapCameraButton()
    func didTapSave(_ source: AvatarSource)
}

#if os(iOS)
import UIKit
import UIKitPlus

public final class ConstructorToolbar: UIView {
    
    enum Constant {
        static let defaultFontSize = 32.0
        static let defaultFontName = "Helvetica"
        static let defaultStartColor = "#FF0000"
        static let defaultEndColor = "#FFA500"
        static let defaultBackgroundColor = "#00ff00"
        static let defaultTextColor = "#ffffff"
        static let defaultName = ""
    }

    // MARK: - Default ViewState

    public struct ViewState {
        public let defaultFontSize: Double
        public let defaultFontName: String
        public let defaultStartColor: String
        public let defaultEndColor: String
        public let defaultBackgroundColor: String
        public let defaultTextColor: String
        public let defaultName: String

        public init(defaultFontSize: Double, defaultFontName: String, defaultStartColor: String, defaultEndColor: String, defaultBackgroundColor: String, defaultTextColor: String, defaultName: String) {
            self.defaultFontSize = defaultFontSize
            self.defaultFontName = defaultFontName
            self.defaultStartColor = defaultStartColor
            self.defaultEndColor = defaultEndColor
            self.defaultBackgroundColor = defaultBackgroundColor
            self.defaultTextColor = defaultTextColor
            self.defaultName = defaultName
        }
    }

    // MARK: - Private Properties

    private var selectedFontSize = Constant.defaultFontSize
    private var selectedFontName = Constant.defaultFontName
    private var selectedStartColor = Constant.defaultStartColor
    private var selectedEndColor = Constant.defaultEndColor
    private var selectedBackgroundColor = Constant.defaultBackgroundColor
    private var selectedTextColor = Constant.defaultTextColor
    private var selectedName = Constant.defaultName

    public var delegate: ConstructorToolbarProtocol?

    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.placeholder = "Team space name"
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: 58).isActive = true
        textField.textAlignment = .center
        textField.returnKeyType = .done
        return textField
    }()

    private lazy var gradientStartColorLabel: UILabel = {
        getIndicatorLabel(with: "Gradient start color: ")
    }()

    private lazy var gradientStartColorWell: UIColorWell = {
        getColorWell()
    }()

    private lazy var gradientStartStackView: UIStackView = {
        getColorStack(with: [gradientStartColorLabel, gradientStartColorWell])
    }()

    private lazy var gradientEndColorLabel: UILabel = {
        getIndicatorLabel(with: "Gradient end color: ")
    }()

    private lazy var gradientEndColorWell: UIColorWell = {
        getColorWell()
    }()

    private lazy var gradientEndStackView: UIStackView = {
        getColorStack(with: [gradientEndColorLabel, gradientEndColorWell])
    }()

    private lazy var backgroundColorLabel: UILabel  = {
        getIndicatorLabel(with: "Background color: ")
    }()

    private lazy var backgroundColorWell: UIColorWell = {
        getColorWell()
    }()

    private lazy var backgroundColorStackView: UIStackView = {
        getColorStack(with: [backgroundColorLabel, backgroundColorWell])
    }()

    private lazy var textColorLabel: UILabel = {
        getIndicatorLabel(with: "Text color: ")
    }()

    private lazy var textColorWell: UIColorWell = {
        getColorWell()
    }()

    private lazy var textColorStackView: UIStackView = {
        getColorStack(with: [textColorLabel, textColorWell])
    }()

    private lazy var gradientSwitchLabel: UILabel = {
        getIndicatorLabel(with: "Use gradient: ")
    }()

    private lazy var gradientSwitch: UISwitch = {
        let uiSwitch = UISwitch()
        uiSwitch.addTarget(self, action: #selector(switchValueChanged(uiSwitch: )), for: .valueChanged)
        uiSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return uiSwitch
    }()

    private lazy var gradientSwitchStackView: UIStackView = {
        getColorStack(with: [gradientSwitchLabel, gradientSwitch])
    }()

    private lazy var openCameraButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.backgroundColor = UIColor(hex: "#334A9E")
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Open Camera", for: .normal)
        btn.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 58).isActive = true
        return btn
    }()

    private lazy var saveButton: UIButton = {
        let btn = UIButton()
        btn.layer.cornerRadius = 12
        btn.backgroundColor = UIColor(hex: "#334A9E")
        btn.setTitleColor(.white, for: .normal)
        btn.setTitle("Save", for: .normal)
        btn.addTarget(self, action: #selector(saveAction), for: .touchUpInside)
        btn.heightAnchor.constraint(equalToConstant: 58).isActive = true
        return btn
    }()

    @objc private func openCamera() {
        delegate?.didTapCameraButton()
    }

    @objc private func saveAction() {
        delegate?.didTapSave(didChangeSourceConfig())
    }

    private lazy var mainStack: UIStackView = {
        gradientSwitch.isOn = false
        gradientStartStackView.isHidden = true
        gradientEndStackView.isHidden = true
        backgroundColorStackView.isHidden = false
        let stack = UIStackView(arrangedSubviews: [
            textField,
            gradientSwitchStackView,
            gradientStartStackView,
            gradientEndStackView,
            backgroundColorStackView,
            textColorStackView,
            openCameraButton,
            saveButton
        ])
        stack.axis = .vertical
        stack.spacing = 16.0
        stack.translatesAutoresizingMaskIntoConstraints = false

        addSubview(stack)

        NSLayoutConstraint.activate([
            stack.leadingAnchor.constraint(equalTo: leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: bottomAnchor),
            stack.topAnchor.constraint(equalTo: topAnchor)
        ])

        return stack
    }()

    // MARK: - Initialization

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

    // MARK: - Private methods

    private func setupView() {
        mainStack.isHidden = false
    }

    @objc private func colorWellValueChanged(colorWell: UIColorWell) {
        if let selectedColor = colorWell.selectedColor {
            switch colorWell {
            case gradientStartColorWell:
                selectedStartColor = selectedColor.toHex()
            case gradientEndColorWell:
                selectedEndColor = selectedColor.toHex()
            case backgroundColorWell:
                selectedBackgroundColor = selectedColor.toHex()
            case textColorWell:
                selectedTextColor = selectedColor.toHex()
            default:
                break
            }
            didChangeSourceConfig()
        }
    }

    @objc private func switchValueChanged(uiSwitch: UISwitch) {
        gradientStartStackView.isHidden = !uiSwitch.isOn
        gradientEndStackView.isHidden = !uiSwitch.isOn
        backgroundColorStackView.isHidden = uiSwitch.isOn
        didChangeSourceConfig()
    }

    @discardableResult
    private func didChangeSourceConfig() -> AvatarSource {
        let source: AvatarSource = gradientSwitch.isOn ? .gradientColor(.init(
            fontSize: selectedFontSize,
            fontName: selectedFontName,
            startColor: selectedStartColor,
            endColor: selectedEndColor,
            textColor: selectedTextColor,
            name: selectedName
        )) : .solidColor(.init(
            fontSize: selectedFontSize,
            fontName: selectedFontName,
            backgroundColor: selectedBackgroundColor,
            textColor: selectedTextColor,
            name: selectedName
        ))
        if gradientSwitch.isOn {
            delegate?.didChangeSource(source)
        } else {
            delegate?.didChangeSource(source)
        }

        return source
    }

    // MARK: - Public Methods

    public func apply(_ viewState: ViewState) {
        selectedFontSize = viewState.defaultFontSize
        selectedFontName = viewState.defaultFontName
        selectedStartColor = viewState.defaultStartColor
        selectedEndColor = viewState.defaultEndColor
        selectedBackgroundColor = viewState.defaultBackgroundColor
        selectedTextColor = viewState.defaultTextColor
        selectedName = viewState.defaultName

        gradientStartColorWell.selectedColor = UIColor(hex: selectedStartColor)
        gradientEndColorWell.selectedColor = UIColor(hex: selectedEndColor)
        backgroundColorWell.selectedColor = UIColor(hex: selectedBackgroundColor)
        textColorWell.selectedColor = UIColor(hex: selectedTextColor)
        textField.text = selectedName
    }

    public func apply(_ designSystem: DesignSystem) {
        textField.font = designSystem.textViewFont
        textField.textColor = designSystem.textViewColor

        [
            textColorLabel,
            gradientEndColorLabel,
            gradientStartColorLabel,
            backgroundColorLabel,
            gradientSwitchLabel
        ].forEach {
            $0.textColor = designSystem.optionTitleColor
            $0.font = designSystem.optionTItleFont
        }

        [openCameraButton, saveButton].forEach {
            $0.setTitleColor(designSystem.buttonTitleColor)
            $0.titleLabel?.font = designSystem.buttonFont
            $0.backgroundColor = designSystem.buttonColor
        }

        backgroundColor = designSystem.backgroundColor
    }
}

private extension ConstructorToolbar {
    func getColorWell() -> UIColorWell {
        let well = UIColorWell()
        well.addTarget(self, action: #selector(colorWellValueChanged(colorWell: )), for: .valueChanged)
        well.translatesAutoresizingMaskIntoConstraints = false
        return well
    }

    func getColorStack(with subviews: [UIView]) -> UIStackView {
        let stack = UIStackView(arrangedSubviews: subviews)
        stack.axis = .horizontal
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = true
        stack.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return stack
    }

    func getIndicatorLabel(with text: String) -> UILabel {
        let label = UILabel()
        label.textAlignment = .left
        label.text = text
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
}

extension ConstructorToolbar: UITextFieldDelegate {

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let swiftRange = Range(range, in: text) {
            let concatenatedString = text.replacingCharacters(in: swiftRange, with: string)
            selectedName = concatenatedString
            didChangeSourceConfig()
        }

        return true
    }

    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // Dismiss the keyboard
        return true
    }
}

#elseif os(macOS)


#endif
