/// Реализация презентера для TodoList
final class TodoListPresenter {
	weak var view: ITodoListViewInput?
	private let sectionForTaskManager: ISectionForTaskManagerAdapter
	
	init( sectionForTaskManager: ISectionForTaskManagerAdapter) {
		self.sectionForTaskManager = sectionForTaskManager
	}
	
	private func mapViewData() -> TodoListModel.ViewData {
		var sections = [TodoListModel.ViewData.Section]()
		for section in sectionForTaskManager.getSections() {
			let sectionData = TodoListModel.ViewData.Section(
				title: section.title,
				tasks: mapTasksData(tasks: sectionForTaskManager.getTasksForSection(section: section) )
			)
			sections.append(sectionData)
		}
		
		return TodoListModel.ViewData(tasksBySection: sections)
	}
	
	private func mapTasksData(tasks: [Task]) -> [TodoListModel.ViewData.Task] {
		tasks.compactMap{ mapTaskData(task: $0) }
	}
	
	private func mapTaskData(task: Task) -> TodoListModel.ViewData.Task? {
		let callback = { [weak self] in
			guard let self = self else { return }
			task.completed.toggle()
			self.view?.renderData(viewData: self.mapViewData())
		}
		
		if let task = task as? RegularTask {
			return .regularTask(TodoListModel.ViewData.RegularTaskViewModel(task: task, callback: callback))
		}
		if let task = task as? ImportantTask {
			return .importantTask(TodoListModel.ViewData.ImportantTaskViewModel(task: task, callback: callback))
		}
		return nil
	}
}

// MARK: ITodoListPresenterInput

extension TodoListPresenter: ITodoListPresenterInput {
	func viewDidLoad() {
		view?.renderData(viewData: mapViewData())
	}
}
