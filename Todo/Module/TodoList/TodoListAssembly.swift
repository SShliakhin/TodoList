import UIKit

final class TodoListAssembly {
	
	/// Собирает модуль todoList
	/// - Returns: модуль todoList
	func assemble() -> UIViewController {
		
		let presenter = TodoListPresenter()
		let interactor = TodoListInteractor(presenter: presenter)
		let view = TodoListViewController(interactor: interactor)
		presenter.view = view

		return view
	}
}
