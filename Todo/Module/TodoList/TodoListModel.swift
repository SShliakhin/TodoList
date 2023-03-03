import Foundation

enum TodoListModel {
	enum FetchTasks {
		struct Request {}
		struct Response {
			struct Section {
				let title: String
				let tasks: [Task]
			}
			
			let tasksBySection: [Section]
			var callback: ((_ task: Task) -> Void)? = nil
		}
		struct ViewData {
			/// Предоставляет модель для обычной задачи
			struct RegularTaskViewModel: CellViewModel {
				let task: RegularTask
				var title: String {
					task.title
				}
				var completed: Bool {
					task.completed
				}
				var callback: ((_ task: Task) -> Void)? = nil
				
				func setup(cell: RegularTaskCell) {
					cell.task = self
				}
			}
			
			/// Предоставляет модель для важной задачи
			struct ImportantTaskViewModel: CellViewModel {
				let task: ImportantTask
				var completed: Bool {
					task.completed
				}
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
				var callback: ((_ task: Task) -> Void)? = nil
				
				func setup(cell: ImportantTaskCell) {
					cell.task = self
				}
			}
			
			/// Тип вьюмодели
			enum TaskVM {
				case regularTask(RegularTaskViewModel)
				case importantTask(ImportantTaskViewModel)
			}
			
			struct Section {
				let title: String
				let tasks: [TaskVM]
			}
			
			let tasksBySection: [Section]
		}
	}
}


// MARK: - View -> Interactor
protocol ITodoListBusinessLogic {
	func fetchTasks(request: TodoListModel.FetchTasks.Request)
}

// MARK: - Interactor -> Worker
protocol ITodoListWorker {
	func loadTasks(
		completion: @escaping (Result<Login.Authorization.Response, Login.Authorization.ErrorAuth>)->Void
	)
}

// MARK: - Interactor -> Presenter
protocol ITodoListPresentationLogic {
	func showTodoList(response: TodoListModel.FetchTasks.Response)
}

// MARK: - Presenter -> View
protocol ITodoListDisplayLogic: AnyObject {
	func render(_ viewData: TodoListModel.FetchTasks.ViewData)
}
