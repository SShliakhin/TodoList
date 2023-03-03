final class LoginWorker: ILoginWorker {
	
	/// Проверяет валидность переданных данных
	/// - Parameters:
	///   - login: логин
	///   - password: пароль
	///   - completion: завершает удачей - ответ или неудачей - ошибка
	func isValid(
		login: String?,
		password: String?,
		completion: @escaping (Result<Login.Authorization.Response, Login.Authorization.ErrorAuth>) -> Void
	) {
		guard
			let login = login,
			let password = password
		else {
			return completion(.failure(.incorrectData))
		}
		
		if login != "Admin" {
			return completion(.failure(.incorrectLogin))
		}
		
		if password != "pa$$32!" {
			return completion(.failure(.incorrectPassword))
		}

		return completion(.success(Login.Authorization.Response()))
	}
}
