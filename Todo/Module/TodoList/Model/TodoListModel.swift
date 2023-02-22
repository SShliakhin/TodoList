import Foundation

enum TodoListModel {
	struct ViewData {
		/// Предоставляет модель для обычной задачи
		struct RegularTaskViewModel {
			let task: RegularTask
			var title: String {
				task.title
			}
			var completed: Bool {
				task.completed
			}
			var callback: (() -> Void)? = nil
		}
		
		/// Предоставляет модель для важной задачи
		struct ImportantTaskViewModel {
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
			var callback: (() -> Void)? = nil
		}
		
		/// Тип вьюмодели
		enum Task {
			case regularTask(RegularTaskViewModel)
			case importantTask(ImportantTaskViewModel)
		}
		
		struct Section {
			let title: String
			let tasks: [Task]
		}
		
		let tasksBySection: [Section]
	}
}

// MARK: - CellViewModel

extension TodoListModel.ViewData.RegularTaskViewModel: CellViewModel {
	func setup(cell: RegularTaskCell) {
		cell.task = self
	}
}

extension TodoListModel.ViewData.ImportantTaskViewModel: CellViewModel {
	func setup(cell: ImportantTaskCell) {
		cell.task = self
	}
}
