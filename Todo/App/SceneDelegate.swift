import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	
	var window: UIWindow?
	
	func scene(
		_ scene: UIScene,
		willConnectTo session: UISceneSession,
		options connectionOptions: UIScene.ConnectionOptions
	) {
		guard let windowScene = (scene as? UIWindowScene) else { return }
		let window = UIWindow(windowScene: windowScene)
		
		let repository = TaskRepositoryStub()
		let taskManager = OrderedTaskManager(taskManager: TaskManager(tasks: repository.getTasks()))
		let sectionForTaskManager = SectionForTaskManagerAdapter(taskManager: taskManager)
		
		let presenter = TodoListPresenter(sectionForTaskManager: sectionForTaskManager)
		let view = TodoListViewController(presenter: presenter)
		presenter.view = view
		
		window.rootViewController = UINavigationController(rootViewController: view)
		
		window.makeKeyAndVisible()
		self.window = window
	}
}
