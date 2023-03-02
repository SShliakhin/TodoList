import UIKit

/// Реализация вьюконтроллера TodoList
final class TodoListViewController: UIViewController {
	private let presenter: ITodoListViewOutput
	private var viewData: TodoListModel.ViewData = TodoListModel.ViewData(tasksBySection: [])
	
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
		
		presenter.viewDidLoad()
	}
}

// MARK: - UITableViewDataSource

extension TodoListViewController: UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
		viewData.tasksBySection.count
	}
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		viewData.tasksBySection[section].title
	}
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		viewData.tasksBySection[section].tasks.count
	}
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let tasks = viewData.tasksBySection[indexPath.section].tasks
		let taskData = tasks[indexPath.row]
		
		switch taskData {
		case .importantTask(let task):
			return tableView.dequeueReusableCell(withModel: task, for: indexPath)
		case .regularTask(let task):
			return tableView.dequeueReusableCell(withModel: task, for: indexPath)
		@unknown default:
			return UITableViewCell()
		}
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

// MARK: - ITodoListViewInput

extension TodoListViewController: ITodoListViewInput {
	func renderData(viewData: TodoListModel.ViewData) {
		self.viewData = viewData
		tableView.reloadData()
	}
}

// MARK: - UIComponent
private extension TodoListViewController {
	private func setup() {
		tableView.register(
			models: [
				TodoListModel.ViewData.RegularTaskViewModel.self,
				TodoListModel.ViewData.ImportantTaskViewModel.self
			]
		)
		tableView.dataSource = self
		tableView.delegate = self
	}
	
	func applyStyle() {
		title = Appearance.title
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

// MARK: - Appearance
extension TodoListViewController {
	enum Appearance {
		static let title = "Todo list"
	}
}
