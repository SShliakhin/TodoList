final class LoginInteractor {
	private let presenter: ILoginPresentationLogic
	private let worker: ILoginWorker
	
	init (presenter: ILoginPresentationLogic, worker: ILoginWorker) {
		self.presenter = presenter
		self.worker = worker
	}
}

// MARK: LoginBusinessLogic

extension LoginInteractor: ILoginBusinessLogic {
	
	/// Пытается залогиниться
	/// - Parameter request: параметры для регистрации
	func tryLogin(request: Login.Authorization.Request) {
		worker.isValid(login: request.login, password: request.password) { [weak self] result in
			guard let self = self else { return }
			switch result {
			case .success(let response):
				self.presenter.showLogingSuccess(response: response)
			case .failure(let error):
				self.presenter.showLogingFailure(error: error)
			}
		}
	}
}
