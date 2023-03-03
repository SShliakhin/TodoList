import Foundation

final class TodoListInteractor: ITodoListBusinessLogic {
	private let presenter: ITodoListPresentationLogic
	private let sectionForTaskManager: ISectionForTaskManagerAdapter

	init(presenter: ITodoListPresentationLogic) {
		self.presenter = presenter
		
		let repository = TaskRepositoryStub()
		let taskManager = OrderedTaskManager(taskManager: TaskManager(tasks: repository.getTasks()))
		sectionForTaskManager = SectionForTaskManagerAdapter(taskManager: taskManager)
	}
	
	func fetchTasks(request: TodoListModel.FetchTasks.Request) {
		var sections: [TodoListModel.FetchTasks.Response.Section] = []
		for section in sectionForTaskManager.getSections() {
			let sectionData = TodoListModel.FetchTasks.Response.Section(
				title: section.title,
				tasks: sectionForTaskManager.getTasksForSection(section: section)
			)
			sections.append(sectionData)
		}
		
		let response = TodoListModel.FetchTasks.Response(
			tasksBySection: sections) { [weak self] task in
				task.completed.toggle()
				self?.fetchTasks(request: .init())
			}
		
		presenter.showTodoList(response: response)
	}
}
