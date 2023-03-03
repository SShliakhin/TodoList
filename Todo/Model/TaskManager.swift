// Предоставляет список задач
final class TaskManager {
	private var taskList = [Task]()
	
	init(tasks: [Task]) {
		self.taskList = tasks
	}
	
	/// Предоставляет список всех задач
	/// - Returns: массив задач
	func allTasks() -> [Task] {
		taskList
	}
	/// Предоставляет список завершенных задач
	/// - Returns: массив завершенных задач
	func completedTasks() -> [Task] {
		taskList.filter{ $0.completed }
	}
	/// Предоставляет список незавершенных задач
	/// - Returns: массив незавершенных задач
	func uncompletedTasks() -> [Task] {
		taskList.filter{ !$0.completed }
	}
	/// Добавить задачу
	/// - Parameter task: задача на добавление
	func addTask(task: Task) {
		taskList.append(task)
	}
	/// Добавить задачи
	/// - Parameter tasks: массив задач
	func addTasks(tasks: [Task]) {
		taskList.append(contentsOf: tasks)
	}
	/// Удалить задачу
	/// - Parameter task: задача на удаление
	func removeTask(task: Task) {
		taskList.removeAll{ $0 === task }
	}
}
