import UIKit

//extension UIColor {
//    convenience init(hex: String) {
//        let hexNumber = Int(hex, radix: 16) ?? 0
//        self.init(red: CGFloat((hexNumber >> 16) & 0xFF) / 255.0,
//                  green: CGFloat((hexNumber >> 8) & 0xFF) / 255.0,
//                  blue: CGFloat(hexNumber & 0xFF) / 255.0,
//                  alpha: 1.0)
//    }
//}
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        guard hexSanitized.count == 6, let hexNumber = Int(hexSanitized, radix: 16) else {
            self.init(white: 0.0, alpha: alpha) // Возвращает черный цвет, если hex некорректен
            return
        }

        self.init(
            red: CGFloat((hexNumber >> 16) & 0xFF) / 255.0,
            green: CGFloat((hexNumber >> 8) & 0xFF) / 255.0,
            blue: CGFloat(hexNumber & 0xFF) / 255.0,
            alpha: alpha
        )
    }

    /// Адаптивный цвет, меняющийся в зависимости от темы (светлая/темная)
    static func adaptiveColor(lightHex: String, darkHex: String) -> UIColor {
        return UIColor { traitCollection in
            let hex = traitCollection.userInterfaceStyle == .dark ? darkHex : lightHex
            return UIColor(hex: hex)
        }
    }
}
