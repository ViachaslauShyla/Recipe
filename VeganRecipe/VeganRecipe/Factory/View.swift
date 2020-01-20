import Foundation

class View {

    static func makeDetailView(showView: UIView, hideView: UIView) -> UIView {
        let containerDetailView = UIView(frame: CGRect.zero)

        let label = UILabel(frame: CGRect.zero)
        label.text = "Detail Search"
        label.font = Font.title.ui
        label.translatesAutoresizingMaskIntoConstraints = false

        containerDetailView.addSubview(label)
        containerDetailView.addSubview(showView)
        containerDetailView.addSubview(hideView)

        let detailView = UIView(frame: .zero)

        let lineView = UIView(frame: .zero)
        lineView.backgroundColor = .gray

        detailView.addSubview(containerDetailView)
        containerDetailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            // setupContainerDetailViewConstraints
            label.topAnchor.constraint(equalTo: containerDetailView.topAnchor),
            label.leadingAnchor.constraint(equalTo: containerDetailView.leadingAnchor),
            label.bottomAnchor.constraint(equalTo: containerDetailView.bottomAnchor),
            showView.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            showView.topAnchor.constraint(equalTo: containerDetailView.topAnchor),
            showView.trailingAnchor.constraint(equalTo: containerDetailView.trailingAnchor),
            showView.bottomAnchor.constraint(equalTo: containerDetailView.bottomAnchor),
            hideView.leadingAnchor.constraint(equalTo: label.trailingAnchor),
            hideView.topAnchor.constraint(equalTo: containerDetailView.topAnchor),
            hideView.trailingAnchor.constraint(equalTo: containerDetailView.trailingAnchor),
            hideView.bottomAnchor.constraint(equalTo: containerDetailView.bottomAnchor),
            label.widthAnchor.constraint(equalTo: showView.widthAnchor, multiplier: 5),
            label.widthAnchor.constraint(equalTo: hideView.widthAnchor, multiplier: 5),

            //setupDetailViewConstraints
            containerDetailView.topAnchor.constraint(equalTo: detailView.topAnchor),
            containerDetailView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor, constant: 20),
            containerDetailView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor, constant: -20),
            containerDetailView.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: 8),
            lineView.leadingAnchor.constraint(equalTo: detailView.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: detailView.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: detailView.bottomAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 2)

        ])

        detailView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        detailView.backgroundColor = .lightGray

        return detailView
    }

    static func makeExpandView(with labels: [UILabel], widht: CGFloat) -> UIView {
        let expandView = UIView()
        let offset: CGFloat = 16

        for label in labels {

            let lastLabelFrame = expandView.subviews.last?.frame ?? CGRect.zero
            let shouldSetupLabelInNextColumn = lastLabelFrame.origin.x + lastLabelFrame.size.width + offset + label.intrinsicContentSize.width + offset > widht
            var positionX: CGFloat = 0.0
            var positionY: CGFloat = 0.0

            if shouldSetupLabelInNextColumn {
                 positionX = offset
                 positionY = lastLabelFrame.origin.y + lastLabelFrame.size.height + offset
            } else {
                 positionX = lastLabelFrame.origin.x + lastLabelFrame.size.width + offset
                 positionY = lastLabelFrame.origin.y
            }

            label.frame = CGRect(x: positionX, y: positionY, width: label.intrinsicContentSize.width, height: label.intrinsicContentSize.height)
            label.backgroundColor = .green
            expandView.addSubview(label)
        }

        expandView.translatesAutoresizingMaskIntoConstraints = false
        expandView.heightAnchor.constraint(equalToConstant: expandView.subviews.last!.frame.origin.y + expandView.subviews.last!.frame.size.height + offset).isActive = true

        return expandView
    }

    static func makeViewWith(labels: [UILabel], width: CGFloat) -> UIView {

        let spacing: CGFloat = 16.0
        let mainStackView = UIStackView()
        mainStackView.axis = .vertical
        mainStackView.spacing = spacing

        var widthsLabels: CGFloat = 0.0
        var tempLabels = [UILabel]()

        func getHorizontalStackView() -> UIStackView {
            let stackView = UIStackView(arrangedSubviews: tempLabels)
            stackView.axis = .horizontal
            stackView.distribution = .fillProportionally
            stackView.spacing = spacing

            return stackView
        }

        for (index, label) in labels.enumerated() {
            label.backgroundColor = .green
            widthsLabels += label.intrinsicContentSize.width + spacing
            if width < widthsLabels {
                let stackView = getHorizontalStackView()
                mainStackView.addArrangedSubview(stackView)
                widthsLabels = label.intrinsicContentSize.width + spacing
                tempLabels = [label]
            } else {
                tempLabels.append(label)
                if index == labels.count - 1 {
                    let stackView = getHorizontalStackView()
                    mainStackView.addArrangedSubview(stackView)
                }
            }

        }

//        let containerView = UIView()
//        containerView.addSubview(mainStackView)
//        mainStackView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            mainStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
//            mainStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
//            containerView.heightAnchor.constraint(equalTo: mainStackView.heightAnchor),
//            containerView.widthAnchor.constraint(equalTo: mainStackView.widthAnchor, constant: 40)
//        ])

        return mainStackView
    }

    
}


