import UIKit

class PopularViewController: UIViewController {
    private struct Constants {
        static let navigationTitle = "Popular Recipes"
        static let cellIdentifier = "collectionViewCellIdentifire"
        static let bottomInset: CGFloat = 100.0
    }

    private var viewModel: PopularModelViewProtocol

    private var containerSearchView: ContainerSearchView = {
        let v = ContainerSearchView(frame: .zero) { request in
            //api.request(request)
        }

        return v
    }()

    lazy private var requestIndicatorView: UIView = {
        return UIView(frame: CGRect(x: 0, y: collectionView.contentSize.height - Constants.bottomInset, width: collectionView.frame.width, height: Constants.bottomInset))
    }()

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: Constants.cellIdentifier)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.black

        return cv
    }()

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = PopularModelView(api: OAIDefaultApi())
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        self.viewModel = PopularModelView(api: OAIDefaultApi())
        super.init(coder: coder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupNavigationItem()
        setupNavigationBelowView()
        setupCollectionView()
        //make preview of screen
        viewModel.showFirstRecipes {
            // delete preview
            self.collectionView.reloadData()
        }
    }
}

//MARK: - PrivateMetods
private extension PopularViewController {

    @objc func tapSearchRecipe(_ sender: UIBarButtonItem) {
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.layoutIfNeeded()
      //  navigationController?.setNavigationBarHidden(true, animated: true)
        containerSearchView.showSearch()
    }
}

// MARK: - TransformCell
private extension PopularViewController {
    func getPercent(value: CGFloat) -> CGFloat {
        switch value {
        case value where value > 1: return 1
        case value where value < 0: return 0
        default: return value
        }
    }

    func makeTransformCell(_ cell: UICollectionViewCell) {
        let convertFrame = cell.convert(cell.bounds, to: view)
        var percent: CGFloat = 0
        let fullHeight = view.frame.height

        if convertFrame.minY > 0 {
            let transformOffsetY = fullHeight - cell.frame.height * 2 / 3
            percent = getPercent(value: (convertFrame.minY - transformOffsetY) / (fullHeight - transformOffsetY))

        } else {
            let transformOffsetY = cell.frame.height * 2 / 3
            percent = getPercent(value: (transformOffsetY - convertFrame.maxY) / (transformOffsetY))
        }

        let maxScaleDifference: CGFloat = 0.2
        let scale = percent * maxScaleDifference
        cell.transform = CGAffineTransform(scaleX: (1 - scale), y: (1 - scale))
        cell.alpha = 1 - percent
    }
}

// MARK: - Setup Methods
private extension PopularViewController {
    func setupNavigationBelowView() {
        view.addSubview(containerSearchView)
        containerSearchView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            containerSearchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            containerSearchView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            containerSearchView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ])
    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: containerSearchView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }

    func setupNavigationItem() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapSearchRecipe))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.title = Constants.navigationTitle
    }

    func setupRequestIndicatorView() -> UIActivityIndicatorView {
        collectionView.contentInset.bottom = Constants.bottomInset
        collectionView.addSubview(requestIndicatorView)
        requestIndicatorView.backgroundColor = .red

        let indicatorView = UIActivityIndicatorView(style: .whiteLarge)
        requestIndicatorView.addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.centerXAnchor.constraint(equalTo: requestIndicatorView.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: requestIndicatorView.centerYAnchor).isActive = true

        return indicatorView
    }

    func removeRequestIndicatorView() {
        collectionView.contentInset.bottom = 0.0
        requestIndicatorView.removeFromSuperview()
    }
}

//MARK: - UICollectionViewDataSource
extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? PopularCollectionViewCell

        let recipe = viewModel.recipes[indexPath.row]
        cell?.configureWith(title: recipe.title, imageUrl: recipe.imageUrl)
        
        return cell!
    }
}

//MARK: - UICollectionViewDelegate
extension PopularViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.visibleCells.forEach({ makeTransformCell($0) })

        let maxScrollPosition = scrollView.contentOffset.y + scrollView.bounds.height - scrollView.contentSize.height
        if scrollView.contentSize.height > 0 && maxScrollPosition > 100 {
            let indicatorView = setupRequestIndicatorView()
            indicatorView.stopAnimating()
            viewModel.showMoreRescipes {
                self.removeRequestIndicatorView()
                self.collectionView.reloadData()
            }
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension PopularViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width - 20
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
}
