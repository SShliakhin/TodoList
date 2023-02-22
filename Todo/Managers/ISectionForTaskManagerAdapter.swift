import Foundation

protocol ISectionForTaskManagerAdapter {
	func getSectionsTitles() -> [String]
	func getTasksForSection(section sectionIndex: Int) -> [Task]
}

/// Предоставляет заголовки секций и задачи по запрошенному номеру секции
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	
	/// Получить заголовки секций
	/// - Returns: массив заголовков секций
	func getSectionsTitles() -> [String] {
		return [
			"Umcompleted",
			"Completed"
		]
	}
	
	/// Получить задачи секции
	/// - Parameter sectionIndex: номер секции
	/// - Returns: массив задач по переданному номеру секции
	func getTasksForSection(section sectionIndex: Int) -> [Task] {
		switch sectionIndex {
		case 1:
			return taskManager.completedTasks()
		default:
			return taskManager.uncompletedTasks()
		}
	}
}
