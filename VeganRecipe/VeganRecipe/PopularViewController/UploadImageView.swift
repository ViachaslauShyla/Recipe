import Foundation

class DefaultImageView: UIView {

    let progress: Progress
    var progressView = ProgressView()

    var downloadLabel: UILabel {
        let l = UILabel(frame: .zero)
        l.text = "Downloading ..."
        l.textAlignment = .center

        return l
    }

    var progressView = ProgressView()

    var uploadStackView: UIStackView {
        let sv = UIStackView(frame: .zero)
        sv.addArrangedSubview(progressView)
        sv.addArrangedSubview(downloadLabel)

        return sv
    }

    init(frame: CGRect, progress: Progress) {
        self.progress = progress
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        self.backgroundColor = .gray
        self.addSubview(uploadStackView)
        uploadStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            uploadStackView.topAnchor.constraint(equalTo: topAnchor),
            uploadStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            uploadStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            uploadStackView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }

    func update(with progress: Progress) {
        progressView.progress = progress
    }
}
