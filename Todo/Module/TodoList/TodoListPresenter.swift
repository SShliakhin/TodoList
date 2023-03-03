/// Реализация презентера для TodoList
final class TodoListPresenter {
	weak var view: ITodoListDisplayLogic?
	var callback: ((_ task: Task) -> Void)? = nil
	
	private func mapTasksData(tasks: [Task]) -> [TodoListModel.FetchTasks.ViewData.TaskVM] {
		tasks.compactMap{ mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> TodoListModel.FetchTasks.ViewData.TaskVM? {
		if let task = task as? RegularTask {
			return .regularTask(.init(task: task, callback: callback))
		}
		if let task = task as? ImportantTask {
			return .importantTask(.init(task: task, callback: callback))
		}
		return nil
	}
}

// MARK: ITodoListPresenterInput

extension TodoListPresenter: ITodoListPresentationLogic {
	func showTodoList(response: TodoListModel.FetchTasks.Response) {
		callback = response.callback
		var sections: [TodoListModel.FetchTasks.ViewData.Section] = []
		for section in response.tasksBySection {
			let sectionData = TodoListModel.FetchTasks.ViewData.Section(
				title: section.title,
				tasks: mapTasksData(tasks: section.tasks)
			)
			sections.append(sectionData)
		}
		view?.render(.init(tasksBySection: sections))
	}
}
