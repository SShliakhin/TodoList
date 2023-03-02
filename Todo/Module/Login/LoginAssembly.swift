import UIKit

final class LoginAssembly {
	
	/// Собирает модуль логин
	/// - Returns: модуль логин
	func assemble() -> UIViewController {
		let presenter = LoginPresenter()
	
		let worker = LoginWorker()
		let interactor = LoginInteractor(
			presenter: presenter,
			worker: worker
		)
		
		let router = LoginRouter()
		let view = LoginViewController(
			interactor: interactor,
			router: router)
		
		presenter.viewController = view
		router.viewController = view
		return view
	}
}
