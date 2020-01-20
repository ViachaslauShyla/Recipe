import UIKit

class DoubleSliderView: UIView {
    private struct Constants {
        static let spacing: CGFloat = 8
        static let startPoint = CGPoint(x: 10, y: 10)
        static let minMaxViewsSize = CGSize(width: 20, height: 20)
        static let minMaxLabelHeight: CGFloat = 24
        static let lineViewHeight: CGFloat = 10
        static let carbs = (min: 0, max: 0)
        static let protein = (min: 0, max: 0)
        static let calories = (min: 0, max: 0)
        static let fat = (min: 0, max: 0)
    }

    private var endPoint: CGPoint {
        return CGPoint(x: self.frame.width - (Constants.startPoint.x * 2), y: Constants.startPoint.y)
    }

    private var stackViewHeight: CGFloat {
        return Constants.minMaxViewsSize.height + Constants.minMaxLabelHeight + Constants.spacing
    }

    private let defaultLineView = UIView()
    private let fullLineView = UIView()
    private let minView = UIView()
    private let minLabel = UILabel()
    private let maxView = UIView()
    private let maxLabel = UILabel()

    private var leftFullLineViewConstraint = NSLayoutConstraint()
    private var rightFullLineViewConstraint = NSLayoutConstraint()
    private var leftMinStackViewConstraint = NSLayoutConstraint()
    private var rightMaxStackViewConstraint = NSLayoutConstraint()

    private lazy var minStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.minView, self.minLabel])
        sv.axis = .vertical
        sv.spacing = Constants.spacing

        return sv
    }()

    private lazy var maxStackView: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [self.maxView, self.maxLabel])
        sv.axis = .vertical
        sv.spacing = Constants.spacing

        return sv
    }()

    private var selectValue: (Int, Int) -> Void
    private let expandViewType: ExpandViewType

    init(expandViewType: ExpandViewType, selectValue: @escaping (Int, Int) -> Void) {
        self.expandViewType = expandViewType
        self.selectValue = selectValue
        super.init(frame: .zero)
        self.heightAnchor.constraint(equalToConstant: Constants.minMaxViewsSize.height + Constants.minMaxLabelHeight + Constants.spacing).isActive = true
        setupDefaultLineView()
        setupFullLineView()
        setupMinStackView()
        setupMaxStackView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        defaultLineView.layer.cornerRadius = defaultLineView.frame.height / 2
        defaultLineView.layer.masksToBounds = true
        fullLineView.layer.cornerRadius = fullLineView.frame.height / 2
        fullLineView.layer.masksToBounds = true
        minView.layer.cornerRadius = minView.frame.width / 2
        minView.layer.masksToBounds = true
        maxView.layer.cornerRadius = maxView.frame.width / 2
        maxView.layer.masksToBounds = true
    }

    // MARK: - PrivateMethods
    func getInitialValues(forType type: ExpandViewType) -> (min: Int, max: Int) {
        switch type {
        case .carbs:
            return Constants.carbs
        case .calories:
            return Constants.calories
        case .protein:
            return Constants.protein
        case .fat:
            return Constants.fat
        default:
            return (0,0)
        }
    }

    // MARK: - SetupViewsMethods
    func setupDefaultLineView() {
        self.addSubview(defaultLineView)
        defaultLineView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            defaultLineView.heightAnchor.constraint(equalToConstant: Constants.lineViewHeight),
            defaultLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.startPoint.x),
            defaultLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.startPoint.x),
            defaultLineView.centerYAnchor.constraint(equalTo: self.topAnchor, constant: Constants.startPoint.y)
        ])

        defaultLineView.backgroundColor = .lightGray
    }

    func setupFullLineView() {
        self.addSubview(fullLineView)
        fullLineView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            fullLineView.heightAnchor.constraint(equalToConstant: Constants.lineViewHeight),
            fullLineView.centerYAnchor.constraint(equalTo: self.topAnchor, constant: Constants.startPoint.y)
        ])

        leftFullLineViewConstraint = fullLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: Constants.startPoint.x)
        rightFullLineViewConstraint = fullLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -Constants.startPoint.x)
        leftFullLineViewConstraint.isActive = true
        rightFullLineViewConstraint.isActive = true

        fullLineView.backgroundColor = .blue
    }

    func setupMinStackView() {
        self.addSubview(minStackView)
        minStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            minStackView.widthAnchor.constraint(equalToConstant: Constants.minMaxViewsSize.width),
            minStackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
            minStackView.topAnchor.constraint(equalTo: self.topAnchor),
        ])

        leftMinStackViewConstraint = minStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        leftMinStackViewConstraint.isActive = true

        minView.backgroundColor = .black
        minView.heightAnchor.constraint(equalToConstant: Constants.minMaxViewsSize.height).isActive = true
        minLabel.text = String(getInitialValues(forType: expandViewType).min)
        minLabel.textAlignment = .center
    }

    func setupMaxStackView() {
        self.addSubview(maxStackView)
        maxStackView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            maxStackView.widthAnchor.constraint(equalToConstant: Constants.minMaxViewsSize.width),
            maxStackView.heightAnchor.constraint(equalToConstant: stackViewHeight),
            maxStackView.topAnchor.constraint(equalTo: self.topAnchor),
        ])

        rightMaxStackViewConstraint = maxStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        rightMaxStackViewConstraint.isActive = true

        maxView.backgroundColor = .black
        maxView.heightAnchor.constraint(equalToConstant: Constants.minMaxViewsSize.height).isActive = true
        maxLabel.text = String(getInitialValues(forType: expandViewType).max)
        maxLabel.textAlignment = .center
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if minView.frame.contains(point) {
            let panGuesture = UIPanGestureRecognizer(target: self, action: #selector(startSlader))
            self.addGestureRecognizer(panGuesture)
        }
        if maxView.frame.contains(point) {
            let panGuesture = UIPanGestureRecognizer(target: self, action: #selector(endSlader))
            self.addGestureRecognizer(panGuesture)
        }
        return self
    }

    @objc func startSlader(_ guesture: UIPanGestureRecognizer) {
        let currentPoint = guesture.location(in: self)
        if guesture.state == .changed {
            rightFullLineViewConstraint.constant += CGFloat(Int(currentPoint.x))
            rightMaxStackViewConstraint.constant += CGFloat(Int(currentPoint.x))
        }
    }

    @objc func endSlader(_ guesture: UIPanGestureRecognizer) {
        let currentPoint = guesture.location(in: self)
        if guesture.state == .changed {
            leftFullLineViewConstraint.constant -= CGFloat(Int(currentPoint.x))
            leftMinStackViewConstraint.constant -= CGFloat(Int(currentPoint.x))
        }
    }
}
