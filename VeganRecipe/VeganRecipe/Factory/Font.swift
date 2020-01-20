import Foundation

enum Font {
    case header
    case body
    case title

    var ui: UIFont {
        switch self {
        case .header:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 25) ?? UIFont()
        case .body:
            return UIFont(name: "AppleSDGothicNeo-Medium", size: 15) ?? UIFont()
        case .title:
            return UIFont(name: "ArialHebrew-Light", size: 20) ?? UIFont()
        }
    }
}
