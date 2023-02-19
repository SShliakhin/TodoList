import UIKit

// MARK: View Output (Presenter -> View)
protocol ITodoListViewOutput: AnyObject {
	func getNumberOfSections() -> Int
	func getTitleForHeaderInSection(_ section: Int) -> String?
	func getNumberOfRowsInSection(_ section: Int) -> Int
	func getCell(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
}
