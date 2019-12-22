import UIKit

class PopularViewController: UIViewController {
    private struct Constants {
        static let navigationTitle = "Popular Recipes"
        static let cellIdentifier = "collectionViewCellIdentifire"
    }

    var loadingIndicatorView: UIView?

    var viewModel: PopularModelViewProtocol

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
        setupCollectionView()
        //make preview of screen
        viewModel.uploadRecipes {
            // delete preview
            self.collectionView.reloadData()
        }
        
    }

    @objc func tapSearchRecipe(_ sender: UIBarButtonItem) {

    }

    //MARK: - Private Methods
    private func getPercent(value: CGFloat) -> CGFloat {
        switch value {
        case value where value > 1: return 1
        case value where value < 0: return 0
        default: return value
        }
    }

    private func makeTransformCell(_ cell: UICollectionViewCell) {
        let convertFrame = cell.convert(cell.bounds, to: view)
        var percent: CGFloat = 0
        let fullHeight = view.frame.height + 64

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

    private func makeNewRequest(_ scrollView: UIScrollView) {
        if loadingIndicatorView == nil {
            let offset = self.dataSource.count

            let activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
            loadingIndicatorView = View.makeLoadingViewFor(scrollView, With: activityIndicator)
            scrollView.contentInset.bottom = 100
            scrollView.addSubview(loadingIndicatorView!)
            activityIndicator.startAnimating()

            
//            api.nextSearchComplexRecipe(offset: offset) { [weak self] (resipes) in
//                 self?.dataSource.append(contentsOf: resipes)
//                 activityIndicator.stopAnimating()
//                 activityIndicator.hidesWhenStopped = true
//                 scrollView.contentInset.bottom = 0
//                 self?.loadingIndicatorView = nil
//                 self?.collectionView.reloadData()
//            }
        }
    }
}

private extension PopularViewController {
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
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
}

//MARK: - UICollectionViewDataSource
extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.recipes.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.cellIdentifier, for: indexPath) as? PopularCollectionViewCell

        let recipe = viewModel.recipes[indexPath.row]
        cell?.configureWith(image: nil, title: recipe.title)
//        if let image = recipe.recipeImage {
//            cell?.configureWith(image: image, title: recipe.title)
//        }

        return cell!
    }
}

//MARK: - UICollectionViewDelegate
extension PopularViewController: UICollectionViewDelegate {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        collectionView.visibleCells.forEach({ makeTransformCell($0) })

        let maxScrollY = scrollView.contentOffset.y + scrollView.bounds.height
        if scrollView.contentSize.height > 0 && maxScrollY - scrollView.contentSize.height > 100 {
            makeNewRequest(scrollView)
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
