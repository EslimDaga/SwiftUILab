import SwiftUI

enum PayviaTheme {
    static let brand = Color(red: 0.059, green: 0.082, blue: 0.812)
    static let brandDeep = Color(red: 0.043, green: 0.055, blue: 0.620)
    static let violetGlow = Color(red: 0.451, green: 0.392, blue: 0.961)
    static let violetBright = Color(red: 0.580, green: 0.404, blue: 0.969)
    static let ink = Color(red: 0.063, green: 0.063, blue: 0.094)
}

extension View {
    func payviaBackground() -> some View {
        background {
            PayviaTheme.brand.ignoresSafeArea()
        }
    }
}
