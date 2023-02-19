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
		
		let repository: ITaskRepository = TaskRepositoryStub()
		let taskManager: ITaskManager = OrderedTaskManager(
			taskManager: TaskManager(
				tasks: repository.getTasks()
			)
		)
		let sectionForTaskManager: ISectionForTaskManagerAdapter = SectionForTaskManagerAdapter(taskManager: taskManager)
		
		let presenter = TodoListPresenter(
			taskManager: taskManager,
			sectionForTaskManager: sectionForTaskManager
		)
		
		window.rootViewController = UINavigationController(
			rootViewController: TodoListViewController(
				presenter: presenter
			)
		)
		
		window.makeKeyAndVisible()
		self.window = window
	}
	
}
