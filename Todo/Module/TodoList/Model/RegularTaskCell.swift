import UIKit

/// Реализация ячейки для обычной задачи
final class RegularTaskCell: UITableViewCell {
	var task: RegularTaskViewModel? {
		didSet {
			guard let task = task else { return }
			title.text = task.title
			
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

private extension RegularTaskCell {
	func setup() {
		setCompletedButton.addTarget(self, action: #selector(setCompleted), for: .primaryActionTriggered)
	}
	
	func applyStyle() {
		backgroundColor = .clear
		selectionStyle = .none
	}
	
	func applyLayout() {		
		let stackView = UIStackView(
			arrangedSubviews: [
				setCompletedButton,
				title
			]
		)
		stackView.spacing = Theme.spacing(usage: .standard)

		[
			stackView
		].forEach { item in
			item.translatesAutoresizingMaskIntoConstraints = false
			contentView.addSubview(item)
		}
				
		NSLayoutConstraint.activate([
			stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
			stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
			stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Theme.spacing(usage: .standard2)),
			stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Theme.spacing(usage: .standard2)),
			setCompletedButton.widthAnchor.constraint(equalToConstant: Theme.size(kind: .setCompletedButtonHeightOrWidht)),
			setCompletedButton.heightAnchor.constraint(equalToConstant: Theme.size(kind: .setCompletedButtonHeightOrWidht))
		])
	}
}

// MARK: - Actions
extension RegularTaskCell {
	@objc func setCompleted(_ sender: UIButton) {
		if let callback = task?.callback {
			callback()
		}
	}
}
