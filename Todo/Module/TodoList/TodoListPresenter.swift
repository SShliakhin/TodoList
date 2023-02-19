import UIKit

/// Реализация презентера для TodoList
final class TodoListPresenter {
	private let taskManager: ITaskManager
	private var sectionForTaskManager: ISectionForTaskManagerAdapter
	
	init(
		taskManager: ITaskManager,
		sectionForTaskManager: ISectionForTaskManagerAdapter
	) {
		self.taskManager = taskManager
		self.sectionForTaskManager = sectionForTaskManager
	}
}

// MARK: - Private methods
private extension TodoListPresenter {
	func getCellData(_ indexPath: IndexPath) -> Task? {
		sectionForTaskManager.getTasksForSection(section: indexPath.section)[indexPath.row]
	}
}

// MARK: - ITodoListViewOutput

extension TodoListPresenter: ITodoListViewOutput {
	
	/// Возвращает количество секций
	/// - Returns: количество секций
	func getNumberOfSections() -> Int {
		sectionForTaskManager.getSectionsTitles().count
	}
	
	/// Возвращает название секции
	/// - Parameter section: номер секции
	/// - Returns: название секции по переданному номеру секции
	func getTitleForHeaderInSection(_ section: Int) -> String? {
		sectionForTaskManager.getSectionsTitles()[section]
	}
	
	/// Возвращает количество задач в секции
	/// - Parameter section: номер секции
	/// - Returns: количество задач по переданному номеру секции
	func getNumberOfRowsInSection(_ section: Int) -> Int {
		sectionForTaskManager.getTasksForSection(section: section).count
	}
	
	/// Возвращает заполненную ячейку
	/// - формирует модель по переданным данным
	/// - получает нужную ячейку и
	/// - заполняет ее данными
	/// - Parameters:
	///   - tableView: таблица, для которой необходима ячейка
	///   - indexPath: путь к данным для ячейки
	/// - Returns: заполненная ячейка переданными данными
	func getCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let task = getCellData(indexPath) else { return UITableViewCell() }
		
		let callback = {
			task.completed.toggle()
			tableView.reloadData()
		}
		
		if let task = task as? RegularTask {
			let model = RegularTaskViewModel(from: task, callback: callback)
			return tableView.dequeueReusableCell(withModel: model, for: indexPath)
		}
		
		if let task = task as? ImportantTask {
			let model = ImportantTaskViewModel(from: task, callback: callback)
			return tableView.dequeueReusableCell(withModel: model, for: indexPath)
		}
		
		return UITableViewCell()
	}
}
