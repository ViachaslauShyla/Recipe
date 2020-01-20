import UIKit

class LabelsView: UIView {
    private struct Constants {
        static let spacing: CGFloat = 16
        static let offset: CGFloat = 8
    }

    private var labels: [UILabel]
    private var width: CGFloat
    private var selectLabel: (String, Bool) -> Void
    private var heightLabelsView: CGFloat = 0

    private var mainStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = Constants.spacing

        return sv
    }()

    init(labels: [UILabel], width: CGFloat, selectLabel: @escaping (String, Bool) -> Void) {
        self.labels = labels
        self.width = width
        self.selectLabel = selectLabel
        super.init(frame: .zero)
        fillMainStackView()
        setupMainStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func tapOnLabel(_ guesture: UITapGestureRecognizer) {
        if let label = guesture.view as? UILabel,
            let textLabel = label.text {
            if label.isHighlighted {
                label.isHighlighted = false
                label.backgroundColor = .green
                selectLabel(textLabel, false)
            } else {
                label.isHighlighted = true
                label.backgroundColor = .gray
                selectLabel(textLabel, true)
            }
        }
    }

    private func createHorizontalStackView(labels: [UILabel]) -> UIStackView {
        let sv = UIStackView(arrangedSubviews: labels)
        sv.axis = .horizontal
        sv.distribution = .fillProportionally
        sv.spacing = Constants.spacing

        return sv
    }

    private func fillMainStackView() {
        var tempLabels = [UILabel]()
        var widthsLabels: CGFloat = 0.0
        
        for (index, label) in labels.enumerated() {
            label.backgroundColor = .green
            let tapGuesture = UITapGestureRecognizer(target: self, action: #selector(tapOnLabel))
            label.addGestureRecognizer(tapGuesture)
            label.highlightedTextColor = .red

            widthsLabels += label.intrinsicContentSize.width + Constants.spacing
            if width < widthsLabels {
                let stackView = createHorizontalStackView(labels: tempLabels)
                mainStackView.addArrangedSubview(stackView)
                heightLabelsView += label.intrinsicContentSize.height + Constants.spacing
                widthsLabels = label.intrinsicContentSize.width + Constants.spacing
                tempLabels = [label]
            } else {
                tempLabels.append(label)
                if index == labels.count - 1 {
                    let stackView = createHorizontalStackView(labels: tempLabels)
                    mainStackView.addArrangedSubview(stackView)
                    heightLabelsView += label.intrinsicContentSize.height
                }
            }
        }
    }

    private func setupMainStackView() {
        self.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: self.topAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.offset),
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.offset),
            mainStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.heightAnchor.constraint(equalToConstant: heightLabelsView)
        ])
    }
}
