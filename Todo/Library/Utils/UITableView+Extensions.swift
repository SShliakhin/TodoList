import UIKit

extension UITableView {
	/// Возвращает заполненную моделью ячейку таблицы
	/// - Parameters:
	///   - model: модель
	///   - indexPath: путь к данным
	/// - Returns: заполненная ячейка таблица
	func dequeueReusableCell(withModel model: CellViewAnyModel, for indexPath: IndexPath) -> UITableViewCell {
		let indetifier = String(describing: type(of: model).cellAnyType)
		let cell = self.dequeueReusableCell(withIdentifier: indetifier, for: indexPath)
		
		model.setupAny(cell: cell)
		return cell
	}
	
	/// Регистрация ячеек таблицы по переданному массиву типов моделей
	/// - Parameter models: массив типов моделй
	func register(models: [CellViewAnyModel.Type]) {
		for model in models {
			let identifier = String(describing: model.cellAnyType)
			self.register(model.cellAnyType, forCellReuseIdentifier: identifier)
		}
	}
}
