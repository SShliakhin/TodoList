import UIKit

/// Протокол для любой модели ячейки
protocol CellViewAnyModel {
	static var cellAnyType: UIView.Type { get }
	func setupAny(cell: UIView)
}

/// Протокол для конкретной модели ячейки
protocol CellViewModel: CellViewAnyModel {
	associatedtype CellType: UIView
	func setup(cell: CellType)
}

extension CellViewModel {
	static var cellAnyType: UIView.Type {
		return CellType.self
	}
	
	func setupAny(cell: UIView) {
		if let cell = cell as? CellType {
			setup(cell: cell)
		} else {
			assertionFailure("Wrong usage")
		}
	}
}
