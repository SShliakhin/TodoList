import Foundation

/// Предоставляет список задач, отсортированных по приоритету.
final class OrderedTaskManager: ITaskManager {
	private let taskManager: ITaskManager
	
	init(taskManager: ITaskManager) {
		self.taskManager = taskManager
	}
	
	func allTasks() -> [Task] {
		sorted(tasks: taskManager.allTasks())
	}
	
	func completedTasks() -> [Task] {
		sorted(tasks: taskManager.completedTasks())
	}
	
	func uncompletedTasks() -> [Task] {
		sorted(tasks: taskManager.uncompletedTasks())
	}
	
	func addTask(task: Task) {
		taskManager.addTask(task: task)
	}
	
	func addTasks(tasks: [Task]) {
		taskManager.addTasks(tasks: tasks)
	}
	
	func removeTask(task: Task) {
		taskManager.removeTask(task: task)
	}
	
	private func sorted(tasks: [Task]) -> [Task] {
		tasks.sorted {
			if let task0 = $0 as? ImportantTask, let task1 = $1 as? ImportantTask {
				return task0.taskPriority.rawValue > task1.taskPriority.rawValue
			}
			
			if $0 is ImportantTask, $1 is RegularTask {
				return true
			}
			
			if $0 is RegularTask, $1 is ImportantTask {
				return false
			}
			
			return true
		}
	}
}
