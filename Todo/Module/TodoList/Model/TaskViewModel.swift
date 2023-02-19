import Foundation

protocol TaskViewModel {
	associatedtype T: Task
	var task: T { get }
	var title: String { get }
	var completed: Bool { get set }
	var callback: (() -> Void)? { get }
	
	init(from task: T, callback: (() -> Void)?)
}


/// Предоставляет модель для обычной задачи
struct RegularTaskViewModel: TaskViewModel {
	let task: RegularTask
	var title: String {
		task.title
	}
	var completed: Bool
	var callback: (() -> Void)? = nil
	
	init(from task: RegularTask, callback: (() -> Void)? = nil) {
		self.task = task
		self.completed = task.completed
		self.callback = callback
	}
}

// MARK: - CellViewModel

extension RegularTaskViewModel: CellViewModel {
	func setup(cell: RegularTaskCell) {
		cell.task = self
	}
}


/// Предоставляет модель для важной задачи
struct ImportantTaskViewModel: TaskViewModel {
	let task: ImportantTask
	
	var title: String {
		"\(task.taskPriority) \(task.title)"
	}
	var subtitle: String {
		let dateString = Theme.dateFormatter.string(from: task.deadLine)
		return "deadline: \(dateString)"
	}
	var hasDeadline: Bool {
		task.deadLine < Date()
	}
	
	var completed: Bool
	var callback: (() -> Void)? = nil
	
	init(from task: ImportantTask, callback: (() -> Void)? = nil) {
		self.task = task
		self.completed = task.completed
		self.callback = callback
	}
}

// MARK: - CellViewModel

extension ImportantTaskViewModel: CellViewModel {
	func setup(cell: ImportantTaskCell) {
		cell.task = self
	}
}
