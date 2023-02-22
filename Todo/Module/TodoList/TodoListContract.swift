import UIKit

protocol ITodoListViewInput: AnyObject {
	/// Отображение данных на основе переданной модели.
	/// - Parameter viewData: Модель данных вью.
	func renderData(viewData: TodoListModel.ViewData)
}

protocol ITodoListPresenterInput {
	
	/// View загружена
	func viewDidLoad()
}
typealias ITodoListViewOutput = ITodoListPresenterInput
