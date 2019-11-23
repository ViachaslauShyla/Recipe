import UIKit

class PopularViewController: UIViewController {

    let identifire = "collectionViewCellIdentifire"

    private var dataSource = [RecipeModel]()
    private let searchManager = SearchManager()
    var loadingIndicatorView: UIView?
    var searchVC = UISearchController(searchResultsController: nil)

    lazy var searchBar: UISearchBar = {
        let sb = UISearchBar(frame: CGRect(x: 30, y: (self.navigationController?.navigationBar.frame.height)! + (self.navigationController?.navigationBar.frame.origin.y)! - 40, width: self.view.frame.width - 60, height: 80))
        self.navigationController?.navigationBar.addSubview(sb)
        sb.searchFieldBackgroundPositionAdjustment = UIOffset(horizontal: 0, vertical: -80)
        sb.layer.shadowColor = UIColor.black.cgColor
        sb.layer.shadowOffset = CGSize(width: 0, height: 1)
        sb.layer.shadowOpacity = 0.8


        return sb
    }()


    lazy var detailSearchLabel: UILabel = {
     let l = UILabel(frame: CGRect.zero)
         l.backgroundColor = UIColor.gray
         l.textColor = UIColor.white
         l.font = UIFont(name: "Didot-Bold", size: 25)
         l.text = "Detail Search"
         l.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapDetailSearch)))

       return l
    }()


    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(PopularCollectionViewCell.self, forCellWithReuseIdentifier: identifire)
        cv.delegate = self
        cv.dataSource = self
        cv.backgroundColor = UIColor.black

        return cv
    }()

    func createInterfase() {

        detailSearchLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailSearchLabel)
        view.addSubview(collectionView)

        let safeArea = view.safeAreaLayoutGuide

        NSLayoutConstraint.activate([

            detailSearchLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            detailSearchLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            detailSearchLabel.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            detailSearchLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor),
            detailSearchLabel.heightAnchor.constraint(equalToConstant: 40),

            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            ])
    }

    func startSearchWithDetail() {
        let underView = UIView(frame: CGRect.zero)
        view.addSubview(underView)
        underView.translatesAutoresizingMaskIntoConstraints = false
        underView.backgroundColor = UIColor.white
        let lineView = UIView(frame: CGRect.zero)
        underView.addSubview(lineView)
        lineView.translatesAutoresizingMaskIntoConstraints = false
        lineView.backgroundColor = UIColor.gray

        let barHeight = (self.navigationController?.navigationBar.frame.height)! + (self.navigationController?.navigationBar.frame.origin.y)! 
        let halfSearchBar: CGFloat = 40.0

        NSLayoutConstraint.activate([
            underView.topAnchor.constraint(equalTo: view.topAnchor),
            underView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            underView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            underView.heightAnchor.constraint(equalToConstant: barHeight + halfSearchBar),

            lineView.bottomAnchor.constraint(equalTo: underView.bottomAnchor),
            lineView.trailingAnchor.constraint(equalTo: underView.trailingAnchor),
            lineView.leadingAnchor.constraint(equalTo: underView.leadingAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 1)
            ])

      //  let underHeightConstraint = underView.heightAnchor.constraint(equalToConstant: barHeight)


        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
       let aaa = UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self])
        aaa.translatesAutoresizingMaskIntoConstraints = false
        aaa.heightAnchor.constraint(equalToConstant: 80).isActive = true

        UIView.transition(with: searchBar, duration: 0.5, options: UIView.AnimationOptions.transitionCrossDissolve, animations: {
            self.searchBar.searchFieldBackgroundPositionAdjustment = UIOffset(horizontal: 0, vertical: 0)
        }, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let rightButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(tapSearchRecipe))
        self.navigationItem.rightBarButtonItem = rightButton
        self.navigationItem.title = "Popular Recipes"

        createInterfase()

        searchManager.initialSearchComplexRecipe { (recipes) in
            self.dataSource = recipes

//            for recipe in self.dataSource {
//                let url = URL(string: recipe.imageUrl)!
//                self.searchManager.downloadImageDataBy(url: url, downloadProgress: { (progress) in
//                    if let progress = progress {
//                        print("RecipeName - \(recipe.title) progress - \(progress.totalUnitCount) recived - \(progress.completedUnitCount)")
//                    }
//                }, complition: { (image) in
//                    recipe.recipeImage = image
//                    self.collectionView.reloadData()
//                })
//            }
        }


    }


    @objc func tapDetailSearch(_ sender: UILabel) {

    }


    @objc func tapSearchRecipe(_ sender: UIBarButtonItem) {

//        searchVC.hidesNavigationBarDuringPresentation = false
//        searchVC.obscuresBackgroundDuringPresentation = false
//        searchVC.searchBar.delegate = self
//        navigationItem.searchController = searchVC
//        navigationItem.rightBarButtonItem?.isEnabled = false
        startSearchWithDetail()


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
        let fullHeight = view.frame.height + 64 + (searchVC.searchBar.frame.height)

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

            searchManager.nextSearchComplexRecipe(offset: offset) { [weak self] (resipes) in
                 self?.dataSource.append(contentsOf: resipes)
                 activityIndicator.stopAnimating()
                 activityIndicator.hidesWhenStopped = true
                 scrollView.contentInset.bottom = 0
                 self?.loadingIndicatorView = nil
                 self?.collectionView.reloadData()
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension PopularViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifire, for: indexPath) as? PopularCollectionViewCell

        let recipe = dataSource[indexPath.row]
        cell?.configureWith(image: nil, title: recipe.title)
        if let image = recipe.recipeImage {
            cell?.configureWith(image: image, title: recipe.title)
        }

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

extension PopularViewController: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
      detailSearchLabel.text = ""

    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {


    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      detailSearchLabel.text = "Detail Search"

    }


    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {



    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        
    }

    func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {

    }
}

extension UIImageView {

    func setImageBy(url: URL, downloadProgress: @escaping (Progress?) -> (), complition: @escaping (UIImage?) -> ()) {

        searchManager.downloadImageDataBy(url: URL, downloadProgress: downloadProgress, complition: complition)

    }
}

