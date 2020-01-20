import UIKit

class TextFieldView: UIView {
    private struct Constants {
        static let spacing: CGFloat = 16
        static let offset: CGFloat = 8
        static let textFieldHeignt: CGFloat = 36
    }

    let textField = UITextField()
    let descriptionLabel = UILabel()
    var stratWrite: ((String) -> Void)
    var heightConstraint = NSLayoutConstraint()

    private var contentHeight: CGFloat {
        return Constants.textFieldHeignt + 62 + Constants.spacing
    }

    private var mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = Constants.spacing

        return sv
    }()
    

    init(stratWrite: @escaping (String) -> Void) {
        self.stratWrite = stratWrite
        super.init(frame: .zero)

        commonInit()
        setupMainStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
      //  heightConstraint.constant = contentHeight
    }

    private func commonInit() {
        textField.delegate = self
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .gray
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.heightAnchor.constraint(equalToConstant: Constants.textFieldHeignt).isActive = true
        descriptionLabel.text = "A comma-separated list of ingredients that should/must be used in the recipes. Example: tomato,cheese"
        descriptionLabel.numberOfLines = 0
        mainStackView.addArrangedSubview(textField)
        mainStackView.addArrangedSubview(descriptionLabel)
      //  self.heightAnchor.constraint(equalToConstant: contentHeight).isActive = true
    }

       private func setupMainStackView() {
         self.addSubview(mainStackView)
         mainStackView.translatesAutoresizingMaskIntoConstraints = false

         NSLayoutConstraint.activate([
             mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
             mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.offset),
             mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.offset),
             mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
         ])

        heightConstraint = self.heightAnchor.constraint(equalToConstant: contentHeight)
        heightConstraint.isActive = true
     }
}

extension  TextFieldView: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        stratWrite(textField.text ?? "")
    }

    func textFieldDidChangeSelection(_ textField: UITextField) {
        stratWrite(textField.text ?? "")
    }

}
