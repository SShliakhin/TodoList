import UIKit

enum Theme {
	
	// MARK: - Fonts
	enum FontStyle {
		case preferred(style: UIFont.TextStyle)
	}
	
	static func font(style: FontStyle) -> UIFont {
		let customFont: UIFont
		
		switch style {
		case let .preferred(style: style):
			customFont = UIFont.preferredFont(forTextStyle: style)
		}
		return customFont
	}
	
	// MARK: - Colors
	enum Color {
		case ypBlack
		case ypGray
		case ypBackground
		case ypWhite
		case ypWhiteAlpha50
		case ypRed
		case ypBlue
	}
	
	static func color(usage: Color) -> UIColor {
		let customColor: UIColor
		
		switch usage {
		case .ypBlack:
			customColor = UIColor(named: "ypBlack") ?? UIColor.black
		case .ypGray:
			customColor = UIColor(named: "ypGray") ?? UIColor.systemGray
		case .ypBackground:
			customColor = UIColor(named: "ypBackground") ?? UIColor.systemBackground
		case .ypWhite:
			customColor = UIColor(named: "ypWhite") ?? UIColor.white
		case .ypWhiteAlpha50:
			customColor = UIColor(named: "ypWhiteAlpha50") ?? UIColor.white.withAlphaComponent(0.50)
		case .ypRed:
			customColor = UIColor(named: "ypRed") ?? UIColor.systemRed
		case .ypBlue:
			customColor = UIColor(named: "ypBlue") ?? UIColor.systemBlue
		}
		
		return customColor
	}
	
	// MARK: - Images
	enum ImageAsset: String {
		case successFilled
		case successOutline
	}
	
	static func image(kind: ImageAsset) -> UIImage {
		return UIImage(named: kind.rawValue) ?? .actions
	}
	
	//MARK: - ContentInset
	enum ContentInset {
		case cell
	}
	
	static func contentInset(kind: ContentInset) -> UIEdgeInsets {
		let customInsets: UIEdgeInsets
		
		switch kind {
		case .cell:
			customInsets = .init(
				top: 4,
				left: 16,
				bottom: -4,
				right: -16
			)
		}
		
		return customInsets
	}
	
	// MARK: - Spacing
	enum Spacing {
		case standard
		case standard2
		case standardHalf
		case standard4
	}
	
	static func spacing(usage: Spacing) -> CGFloat {
		let customSpacing: CGFloat
		
		switch usage {
		case .standard:
			customSpacing = 8
		case .standard2:
			customSpacing = 16
		case .standardHalf:
			customSpacing = 4
		case .standard4:
			customSpacing = 32
		}
		
		return customSpacing
	}
	
	// MARK: - Size
	enum Size {
		case cellDefaultHeight
		case setCompletedButtonHeightOrWidht
		case cornerRadius
	}
	
	static func size(kind: Size) -> CGFloat {
		let customSize: CGFloat
		
		switch kind {
		case .cellDefaultHeight:
			customSize = 44
		case .setCompletedButtonHeightOrWidht:
			customSize = 20
		case .cornerRadius:
			customSize = 6
		}
		
		return customSize
	}
	
	// MARK: - DateFormatter
	static let dateFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateStyle = .long
		formatter.timeStyle = .none
		return formatter
	}()
}
