final class LoginPresenter {
	weak var viewController: ILoginDisplayLogic?
}

// MARK: ILoginPresentationLogic

extension LoginPresenter: ILoginPresentationLogic {
	
	/// Подготавливает вьюмодель при успешной регистрации
	/// - Parameter response: успешный ответ
	func showLogingSuccess(response: Login.Authorization.Response) {
		let viewModel = Login.Authorization.ViewModel(route: .toTodoList)
		viewController?.render(viewModel)
	}
	
	/// Подготавливает вьюмодель при неудачной регистрации
	/// - Parameter error: ошибка регистрации
	func showLogingFailure(error: Login.Authorization.ErrorAuth) {
		switch error {
		case .incorrectData:
			let viewModel = Login.Authorization.ViewModel(
				route: .showError("Incorrect data")
			)
			viewController?.render(viewModel)
		case .incorrectLogin:
			let viewModel = Login.Authorization.ViewModel(
				route: .showError("Incorrect login")
			)
			viewController?.render(viewModel)
		case .incorrectPassword:
			let viewModel = Login.Authorization.ViewModel(
				route: .showError("Incorrect password")
			)
			viewController?.render(viewModel)
		}
	}
}
