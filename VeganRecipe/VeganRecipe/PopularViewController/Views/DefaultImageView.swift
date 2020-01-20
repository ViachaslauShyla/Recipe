import Foundation

class DefaultImageView: UIView {
    private struct Constants {
        static let spacing: CGFloat = 8.0
        static let downloadText = "Downloading ..."
    }

    private var containerView = UIView()
    private var progressView = ProgressView()

    private var downloadLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.text = Constants.downloadText
        l.textAlignment = .center

        return l
    }()

    private lazy var stackView: UIStackView = {
        let sv = UIStackView(frame: .zero)
        sv.spacing = Constants.spacing
        sv.axis = .vertical
        sv.addArrangedSubview(progressView)
        sv.addArrangedSubview(downloadLabel)

        return sv
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.backgroundColor = .gray
        setupContainerView()
        setupUploadView()
    }

    func update(with progress: Progress) {
        progressView.progress = progress
    }
}

// MARK: - Setup Methods
private extension DefaultImageView {
    func setupContainerView() {
        self.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: topAnchor),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    func setupUploadView() {
        containerView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.5),
            stackView.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5, constant: downloadLabel.intrinsicContentSize.height),
            stackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
}
