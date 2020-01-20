import UIKit

enum ExpandViewType: String, CaseIterable {
    case types = "Types"
    case cuisines = "Cuisines"
    case excludeCuisines = "Exclude Cuisines"
    case intolerances = "Intolerances"
    case includeIngredients = "Include Ingredients"
    case excludeIngredients = "Exclude Ingredients"
    case carbs = "Min/max Carbs"
    case protein = "Min/max Protein"
    case calories = "Min/max Calories"
    case fat = "Min/max Fat"
}

class DetailSearchViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tv = UITableView(frame: .zero)
        tv.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
        tv.dataSource = self
        tv.delegate = self
        tv.register(DetailSearchTableViewCell.self, forCellReuseIdentifier: String(describing: DetailSearchTableViewCell.self))

        return tv
    }()

    var expandViewTypes: [ExpandViewType] = ExpandViewType.allCases

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        tableView.rowHeight = UITableView.automaticDimension
    }

    func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expandViewTypes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DetailSearchTableViewCell.self), for: indexPath) as? DetailSearchTableViewCell

        cell?.initialConfigure(with: expandViewTypes[indexPath.row].rawValue)
        

        return cell!
    }
}

extension DetailSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as? DetailSearchTableViewCell
        cell?.contentView.isUserInteractionEnabled = true

        if cell?.expandView == nil {
            cell?.expand(forType: expandViewTypes[indexPath.row]) {
            

            }
        }
        tableView.beginUpdates()
        tableView.endUpdates()

    }
}
