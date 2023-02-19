protocol ITaskRepository {
	func getTasks() -> [Task]
}

/// Реализует стаб-репозиторий
final class TaskRepositoryStub: ITaskRepository {
	
	/// Возвращает статичный массив задач
	/// - Returns: массив задач
	func getTasks() -> [Task] {
		[
			ImportantTask(title: "Do homework", taskPriority: .high),
			RegularTask(title: "Do Workout", completed: true),
			ImportantTask(title: "Write new tasks", taskPriority: .low),
			RegularTask(title: "Solve 3 algorithms"),
			ImportantTask(title: "Go shopping", taskPriority: .medium)
		]
	}
}
