import UIKit

class ContainerSearchView: UIView {

   lazy var searchBar: UISearchBar = {
        return UISearchBar(frame: .zero)
    }()

    lazy var detailView: UIView = {
        let v = View.makeDetailView(showView: showView, hideView: hideView)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(showDetail))
        v.addGestureRecognizer(tapGesture)

        return v
    }()

    private let detailSearchVC = DetailSearchViewController()
    lazy private var resultDetailView: UIView = {
        let v = self.detailSearchVC.view!
        return v
    }()

    private var requestDictionary = [String: Any]()
    private var containerHeightConstraint = NSLayoutConstraint()
    var searchRequest: ([String: Any]) -> Void

    var showView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        //draw view

        return view
    }()

    var hideView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        //draw view

        return view
    }()


    init(frame: CGRect, searchRequest: @escaping ([String: Any]) -> Void) {
        self.searchRequest = searchRequest
        super.init(frame: frame)

        setupSearchBar()
        setupDetailView()
        setupResultDetailView()

        searchBar.delegate = self
        containerHeightConstraint = self.heightAnchor.constraint(equalToConstant: 0.0)
        containerHeightConstraint.isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showSearch() {
        UIView.animate(withDuration: 3, animations: {
            self.containerHeightConstraint.constant = 56
        }) { _ in
            UIView.animate(withDuration: 2) {
                self.containerHeightConstraint.constant += 30
            }
        }
    }
}

//MARK: - SetupMethods
extension ContainerSearchView {
    func setupSearchBar() {
        self.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }

    func setupDetailView() {
        self.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            detailView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            detailView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }

    func setupResultDetailView() {
        self.addSubview(resultDetailView)
        resultDetailView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            resultDetailView.topAnchor.constraint(equalTo: detailView.bottomAnchor),
            resultDetailView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            resultDetailView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            resultDetailView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}

extension ContainerSearchView {

    @objc private func showDetail() {
        let screenHeight = UIScreen.main.bounds.height
        containerHeightConstraint.constant = screenHeight - containerHeightConstraint.constant

    }

    func selectDetail() {

    }

    func deselectDetail() {
        
    }
}

//MARK: - UISearchBarDelegate
extension ContainerSearchView: UISearchBarDelegate {

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        requestDictionary["query"] = searchText
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchRequest(requestDictionary)
    }
}
