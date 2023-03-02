import UIKit

final class LoginRouter {
	weak var viewController: UIViewController?
}

// MARK: - ILoginRoutingLogic

extension LoginRouter: ILoginRoutingLogic {
	
	/// Переходит по указанному маршруту
	/// - Parameter route: маршрут перехода
	func navigate(route: Login.Authorization.Route) {
		switch route {
		case .showError(let message):
			viewController?.showErrorDialog(with: message)
		case .toTodoList:
			guard let navigationVC = viewController?.navigationController else {
				viewController?.showErrorDialog(with: "Transition impossible")
				return
			}
			let todoListViewController = TodoListAssembly().assemble()
			navigationVC.viewControllers.insert(todoListViewController, at: 0)
			navigationVC.popToRootViewController(animated: false)
		}
	}
}
