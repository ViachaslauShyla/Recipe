import UIKit

protocol ExpandViewProtocol {

}

class DetailSearchTableViewCell: UITableViewCell {
    private struct Constants {
        static let spacing: CGFloat = 8.0
    }

    private let titleLabel = UILabel()
    private let descriptionTextLabel = UILabel()
    var expandView: UIView?

    private lazy var stackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.titleLabel, self.descriptionTextLabel])
        sv.axis = .vertical
        sv.spacing = Constants.spacing

        return sv
    }()

    //MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStackView()
        titleLabel.font = Font.header.ui
        descriptionTextLabel.font = Font.body.ui
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    //MARK: - PrivateMetods

    private func setupStackView() {
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    //MARK: - PublicMetods

    func initialConfigure(with title: String) {
        titleLabel.text = title
    }

    func expand(forType type: ExpandViewType, updateDescriptionText: @escaping () -> Void) {
        switch type {
        case .types:
            expandView = LabelsView(labels: DetailSearchDataFactory.getTypesDetailLabels(), width: frame.width) { text, isSelect in
                self.updateDescriptionText(text)
            }
            stackView.addArrangedSubview(expandView!)

        case .cuisines, .excludeCuisines:
             expandView = LabelsView(labels: DetailSearchDataFactory.getCuisinesDetailLabels(), width: frame.width) { text, isSelect in
                self.updateDescriptionText(text)
                updateDescriptionText()
            }
            stackView.addArrangedSubview(expandView!)

        case .intolerances:
             expandView = LabelsView(labels: DetailSearchDataFactory.getIntolerancesDetailLabels(), width: frame.width) { text, isSelect in
                self.updateDescriptionText(text)
            }
            stackView.addArrangedSubview(expandView!)

        case .includeIngredients, .excludeIngredients:
            expandView = TextFieldView(stratWrite: { text in
                self.updateDescriptionText(text)
                updateDescriptionText()
            })
            stackView.addArrangedSubview(expandView!)

        case .carbs, .calories, .protein, .fat:
            expandView = DoubleSliderView(expandViewType: type, selectValue: { min, max in
                self.updateDescriptionText("Min - \(min), Max - \(max)")
            })
            stackView.addArrangedSubview(expandView!)
        }
    }

    func updateDescriptionText(_ text: String) {
        if var descriptionText = descriptionTextLabel.text {
            descriptionText += ", " + text
        } else {
            descriptionTextLabel.text = text
        }
    }

    override var canBecomeFirstResponder: Bool {
        if expandView != nil {
            return false
        }
        return true
    }
}
