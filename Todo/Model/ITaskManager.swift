import Foundation

protocol ITaskManager {
	func allTasks() -> [Task]
	func completedTasks() -> [Task]
	func uncompletedTasks() -> [Task]
	func addTask(task: Task)
	func addTasks(tasks: [Task])
	func removeTask(task: Task)
}

// Предоставляет список задач
final class TaskManager: ITaskManager {
	private var taskList = [Task]()
	
	init(tasks: [Task]) {
		self.taskList = tasks
	}
	
	func allTasks() -> [Task] {
		taskList
	}
	
	func completedTasks() -> [Task] {
		taskList.filter{ $0.completed }
	}
	
	func uncompletedTasks() -> [Task] {
		taskList.filter{ !$0.completed }
	}
	
	func addTask(task: Task) {
		taskList.append(task)
	}
	
	func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}
	
	func removeTask(task: Task) {
		taskList.removeAll{ $0 === task }
	}
}

// MARK: - CustomStringConvertible

extension ImportantTask.TaskPriority: CustomStringConvertible {
	var description: String {
		switch self {
		case .high:
			return "!!!"
		case .medium:
			return "!!"
		case .low:
			return "!"
		}
	}
}
