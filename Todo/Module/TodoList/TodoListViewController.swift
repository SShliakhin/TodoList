import UIKit

/// Реализация вьюконтроллера TodoList
final class TodoListViewController: UIViewController {
	private let presenter: ITodoListViewOutput
	
	// MARK: - UI
	private lazy var tableView: UITableView = {
		let tableView = UITableView()
		tableView.backgroundColor = .clear
		tableView.separatorStyle = .none
		tableView.estimatedRowHeight = Theme.size(kind: .cellDefaultHeight)
		tableView.tableFooterView = UIView()
		return tableView
	}()
	
	// MARK: - Init
	init(presenter: ITodoListViewOutput) {
		self.presenter = presenter
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - Lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
		applyStyle()
		applyLayout()
	}
}

// MARK: - UITableViewDataSource

extension TodoListViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		presenter.getNumberOfSections()
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		presenter.getTitleForHeaderInSection(section)
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		presenter.getNumberOfRowsInSection(section)
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		presenter.getCell(tableView, cellForRowAt: indexPath)
	}
}

// MARK: - UITableViewDelegate

extension TodoListViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		tableView.deselectRow(at: indexPath, animated: true)
	}
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return UITableView.automaticDimension
	}
}


// MARK: - UIComponent
private extension TodoListViewController {
	private func setup() {
		presenter.setupTableView(tableView, dataSource: self, delegate: self)
	}
	
	func applyStyle() {
		title = "Todo list"
		navigationController?.navigationBar.prefersLargeTitles = true
		view.backgroundColor = Theme.color(usage: .ypWhite)
	}
	
	func applyLayout() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		view.addSubview(tableView)
		
		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
			tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
		])
	}
}
