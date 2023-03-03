enum Login {
	// MARK: Use cases
	enum Authorization {
		struct Request {
			let login: String?
			let password: String?
		}
		struct Response { }
		enum ErrorAuth: Error {
			case incorrectData
			case incorrectPassword
			case incorrectLogin
		}
		struct ViewModel {
			let route: Route
		}
		enum Route {
			case showError(String)
			case toTodoList
		}
	}
}

// MARK: - View -> Interactor
protocol ILoginBusinessLogic {
	func tryLogin(request: Login.Authorization.Request)
}

// MARK: - Interactor -> Worker
protocol ILoginWorker {
	func isValid(
		login: String?,
		password: String?,
		completion: @escaping (Result<Login.Authorization.Response, Login.Authorization.ErrorAuth>)->Void
	)
}

// MARK: - Interactor -> Presenter
protocol ILoginPresentationLogic {
	func showLogingSuccess(response: Login.Authorization.Response)
	func showLogingFailure(error: Login.Authorization.ErrorAuth)
}

// MARK: - Presenter -> View
protocol ILoginDisplayLogic: AnyObject {
	func render(_ viewModel: Login.Authorization.ViewModel)
}

// MARK: - View -> Router
protocol ILoginRoutingLogic {
	func navigate(route: Login.Authorization.Route)
}
