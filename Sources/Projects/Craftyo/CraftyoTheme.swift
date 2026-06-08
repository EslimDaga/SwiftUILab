import SwiftUI

enum CraftyoTheme {
    static let skyStrong = Color(hex: "29A6FD")
    static let skyMid = Color(hex: "62C4FE")
    static let skyPale = Color(hex: "CDEFFF")

    static let navy = Color(hex: "15294F")
    static let navyDeep = Color(hex: "112141")

    static let accent = Color(hex: "2F6BED")
    static let badge = Color(hex: "F0473E")

    static let canvas = Color(hex: "F4F6F9")
    static let card = Color(hex: "FFFFFF")
    static let field = Color(hex: "F2F4F7")
    static let segmentTrack = Color(hex: "F1F1F1")
    static let stroke = Color(hex: "E6E9F0")
    static let inputStroke = Color(hex: "EDEFF3")

    static let textPrimary = Color(hex: "14213D")
    static let textSecondary = Color(hex: "8B90A0")

    static let garuda = Color(hex: "1E63B3")
    static let lion = Color(hex: "E03A3C")
    static let united = Color(hex: "1A1AA8")
    static let scoot = Color(hex: "F5C518")
}

extension Font {
    static func craftyo(_ size: CGFloat, weight: Font.Weight = .regular) -> Font {
        .system(size: size, weight: weight, design: .default)
    }
}

extension Color {
    init(hex: String) {
        let raw = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var value: UInt64 = 0
        Scanner(string: raw).scanHexInt64(&value)

        let a, r, g, b: UInt64
        switch raw.count {
        case 3:
            (a, r, g, b) = (255, (value >> 8) * 17, (value >> 4 & 0xF) * 17, (value & 0xF) * 17)
        case 6:
            (a, r, g, b) = (255, value >> 16, value >> 8 & 0xFF, value & 0xFF)
        case 8:
            (a, r, g, b) = (value >> 24, value >> 16 & 0xFF, value >> 8 & 0xFF, value & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
