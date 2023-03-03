import UIKit

final class LoginViewController: UIViewController {
	
	// MARK: - UI
	private lazy var titleLabel: UILabel = {
		let label = UILabel()
		label.text = Appearance.titleLableText
		label.textAlignment = .center
		label.font = Theme.font(style: .preferred(style: .title3))
		return label
	}()
	private lazy var loginTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = Appearance.loginTextFieldPlaceholder
		textField.borderStyle = .roundedRect
		textField.textContentType = .username
		textField.font = Theme.font(style: .preferred(style: .body))
		return textField
	}()
	private lazy var passwordTextField: UITextField = {
		let textField = UITextField()
		textField.placeholder = Appearance.passwordTextFieldPlaceholder
		textField.borderStyle = .roundedRect
		textField.textContentType = .password
		textField.isSecureTextEntry = true
		textField.font = Theme.font(style: .preferred(style: .body))
		return textField
	}()
	private lazy var tryLoginButton: UIButton = {
		let button = UIButton()
		button.setTitle(Appearance.tryLoginButtonTitle, for: .normal)
		button.backgroundColor = Theme.color(usage: .ypBlue)
		button.layer.cornerRadius = Theme.size(kind: .cornerRadius)
		return button
	}()
	
	// MARK: - Properties
	private let interactor: ILoginBusinessLogic
	private let router: ILoginRoutingLogic
	
	// MARK: - Init
	init(interactor: ILoginBusinessLogic, router: ILoginRoutingLogic) {
		self.interactor = interactor
		self.router = router
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// MARK: - lifecycle
	override func viewDidLoad() {
		super.viewDidLoad()
		
		setup()
		applyStyle()
		applyLayout()
	}
}

// MARK: - ILoginDisplayLogic

extension LoginViewController: ILoginDisplayLogic {
	/// Рендрит вьюмодель
	/// - Parameter viewModel: вьюмодель
	func render(_ viewModel: Login.Authorization.ViewModel) {
		router.navigate(route: viewModel.route)
	}
}

// MARK: - Actions
private extension LoginViewController {
	@objc func tryLogin(_ sender: UIButton) {
		interactor.tryLogin(
			request: .init(
				login: loginTextField.text,
				password: passwordTextField.text
			)
		)
	}
}

// MARK: - UI Components
private extension LoginViewController {
	func setup() {
		tryLoginButton.addTarget(self, action: #selector(tryLogin), for: .primaryActionTriggered)
	}
	
	func applyStyle() {
		view.backgroundColor = Theme.color(usage: .ypWhite)
	}
	
	func applyLayout() {
		let stackView = UIStackView(
			arrangedSubviews: [
				titleLabel,
				loginTextField,
				passwordTextField,
				tryLoginButton
			]
		)
		stackView.axis = .vertical
		stackView.spacing = Theme.spacing(usage: .standard2)
		
		[
			stackView
		].forEach { item in
			item.translatesAutoresizingMaskIntoConstraints = false
			view.addSubview(item)
		}
		
		NSLayoutConstraint.activate([
			stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Theme.spacing(usage: .standard4)),
			stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Theme.spacing(usage: .standard4)),
			stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
		])
	}
}

// MARK: - Appearance
extension LoginViewController {
	enum Appearance {
		static let titleLableText = "Enter login and password"
		static let loginTextFieldPlaceholder = "Login"
		static let passwordTextFieldPlaceholder = "Password"
		static let tryLoginButtonTitle = "Sign in"
	}
}
