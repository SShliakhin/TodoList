import UIKit

final class TodoListAssembly {
	
	/// Собирает модуль todoList
	/// - Returns: модуль todoList
	func assemble() -> UIViewController {
		let repository = TaskRepositoryStub()
		let taskManager = OrderedTaskManager(taskManager: TaskManager(tasks: repository.getTasks()))
		let sectionForTaskManager = SectionForTaskManagerAdapter(taskManager: taskManager)
		
		let presenter = TodoListPresenter(sectionForTaskManager: sectionForTaskManager)
		let view = TodoListViewController(presenter: presenter)
		presenter.view = view

		return view
	}
}
