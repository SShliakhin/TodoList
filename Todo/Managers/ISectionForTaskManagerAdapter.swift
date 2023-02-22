import Foundation

protocol ISectionForTaskManagerAdapter {
	func getSections() -> [Section]
	func getTasksForSection(section: Section) -> [Task]
	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)?
	func getSectionIndex(section: Section) -> Int
	func getSection(forIndex index: Int) -> Section
}

enum Section: CaseIterable {
	case completed
	case uncompleted
	
	var title: String {
		switch self {
		case .completed:
			return "Completed"
		case .uncompleted:
			return "Uncompleted"
		}
	}
}

/// Предоставляет заголовки секций и задачи по запрошенному номеру секции
final class SectionForTaskManagerAdapter: ISectionForTaskManagerAdapter {
	private let taskManager: ITaskManager
	private let sections: [Section] = [.uncompleted, .completed]
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	/// Получить секции
	/// - Returns: массив секций
	func getSections() -> [Section] {
		sections
	}
	
	/// Получить номер секции
	/// - Parameter section: секция
	/// - Returns: номер секции
	func getSectionIndex(section: Section) -> Int {
		sections.firstIndex(of: section) ?? 0
	}
	
	/// Получить секцию по номеру
	/// - Parameter index: номер
	/// - Returns: секция
	func getSection(forIndex index: Int) -> Section {
		let i = min(index, sections.count - 1)
		return sections[i]
	}
	
	/// Получить задачи секции
	/// - Parameter section: секция
	/// - Returns: массив задач
	func getTasksForSection(section: Section) -> [Task] {
		switch section {
		case .completed:
			return taskManager.completedTasks()
		case .uncompleted:
			return taskManager.uncompletedTasks()
		}
	}
	
	/// Получить секцию и номер задачи в ней по задаче
	/// - Parameter task: задача
	/// - Returns: секция и номер
	func taskSectionAndIndex(task: Task) -> (section: Section, index: Int)? {
		for section in sections {
			let index = getTasksForSection(section: section).firstIndex{ task === $0 }
			if index != nil {
				return (section, index!)
			}
		}
		return nil
	}
}
