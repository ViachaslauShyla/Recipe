import UIKit

class ContainerSearchView: UIView {

    var searchBar: UISearchBar {
        return UISearchBar(frame: .zero)
    }

    var detailView: UIView {
        return View.makeDetailView(showView: showView, hideView: hideView)
    }

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

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupDetailView()
        setupSearchBar()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupSearchBar() {
        self.addSubview(searchBar)
        searchBar.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([

            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    func setupDetailView() {
        self.addSubview(detailView)
        detailView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: self.topAnchor),
            searchBar.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            searchBar.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            searchBar.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
    }

}

extension ContainerSearchView {
    func selectSearchBar() {

    }

    func cancelSearchBar() {

    }

    func selectDetail() {

    }

    func deselectDetail() {
        
    }
}
