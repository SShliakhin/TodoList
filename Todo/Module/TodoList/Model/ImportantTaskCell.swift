import UIKit

/// Реализация ячейки для важной задачи
final class ImportantTaskCell: UITableViewCell {
	var task: TodoListModel.ViewData.ImportantTaskViewModel? {
		didSet {
			guard let task = task else { return }
			title.text = task.title
			subtitle.text = task.subtitle
			
			let color = task.hasDeadline
			? Theme.color(usage: .ypRed)
			: Theme.color(usage: .ypBlack)
			
			title.textColor = color
			
			let imageCompleted = task.completed
			? Theme.image(kind: .successFilled)
			: Theme.image(kind: .successOutline)
			
			setCompletedButton.setImage(imageCompleted, for: .normal)
		}
	}
	
	private lazy var title: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = Theme.font(style: .preferred(style: .body))
		label.textColor = Theme.color(usage: .ypBlack)
		return label
	}()
	
	private lazy var subtitle: UILabel = {
		let label = UILabel()
		label.numberOfLines = 0
		label.font = Theme.font(style: .preferred(style: .caption1))
		label.textColor = Theme.color(usage: .ypBlack)
		return label
	}()
	
	private lazy var setCompletedButton: UIButton = {
		let button = UIButton()
		return button
	}()
	
	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setup()
		applyStyle()
		applyLayout()
	}
	
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
	}
}

private extension ImportantTaskCell {
	func setup() {
		setCompletedButton.addTarget(
			self,
			action: #selector(setCompleted),
			for: .primaryActionTriggered
		)
	}
	
	func applyStyle() {
		backgroundColor = .clear
		selectionStyle = .none
	}
	
	func applyLayout() {
		let stackView = UIStackView(
			arrangedSubviews: [
				title,
				subtitle
			]
		)
		stackView.axis = .vertical
		
		let mainStackView = UIStackView(
			arrangedSubviews: [
				setCompletedButton,
				stackView
			])
		mainStackView.alignment = .center
		mainStackView.spacing = Theme.spacing(usage: .standard)
		
		[
			mainStackView
		].forEach { item in
			item.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(item)
		}
		
		NSLayoutConstraint.activate([
			mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.spacing(usage: .standard2)),
			mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.spacing(usage: .standard2)),
			setCompletedButton.widthAnchor.constraint(equalToConstant: Theme.size(kind: .setCompletedButtonHeightOrWidht)),
			setCompletedButton.heightAnchor.constraint(equalToConstant: Theme.size(kind: .setCompletedButtonHeightOrWidht))
		])
	}
}

// MARK: - Actions
extension ImportantTaskCell {
	@objc func setCompleted(_ sender: UIButton) {
		if let callback = task?.callback {
			callback()
		}
	}
}
