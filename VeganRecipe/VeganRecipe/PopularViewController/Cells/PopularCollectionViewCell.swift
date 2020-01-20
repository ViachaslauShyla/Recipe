import UIKit

class PopularCollectionViewCell: UICollectionViewCell {

    private var imageView = UIImageView()
    private var titleLabel = UILabel()

    override init(frame: CGRect) {
        super .init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    //MARK: - Private Methods
    private func commonInit() {
        self.layer.cornerRadius = 5
        self.layer.masksToBounds = true

        setupImageView()
        setupTitleLabel()
        setupAlphaTitleView()
    }

    //MARK: - Public Methods
    func configureWith(title: String, imageUrl: URL) {
        self.titleLabel.text = title
        self.imageView.showImageBy(imageUrl)
    }
}

// MARK: - Setup Metods
private extension PopularCollectionViewCell {
    func setupTitleLabel() {
        self.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20)
        ])

        titleLabel.font = UIFont(name: "Optima-Bold", size: 30)
        titleLabel.textColor = UIColor.white
        titleLabel.numberOfLines = 0
    }

    func setupAlphaTitleView() {
        let alphaTitleView = UIView(frame: CGRect.zero)
        alphaTitleView.backgroundColor = UIColor.gray
        alphaTitleView.alpha = 0.2

        self.addSubview(alphaTitleView)
        alphaTitleView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            alphaTitleView.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            alphaTitleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            alphaTitleView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            alphaTitleView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }

    func setupImageView() {
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
}
