import SwiftUI
import CoreText

enum AppFont {
    private static let fileNames = [
        "Poppins-Regular",
        "Poppins-Medium",
        "Poppins-SemiBold",
        "Poppins-Bold",
    ]

    static func register() {
        for name in fileNames {
            guard let url = Bundle.main.url(forResource: name, withExtension: "ttf") else { continue }
            CTFontManagerRegisterFontsForURL(url as CFURL, .process, nil)
        }
    }

    static func name(for weight: Font.Weight) -> String {
        switch weight {
        case .bold, .heavy, .black: "Poppins-Bold"
        case .semibold: "Poppins-SemiBold"
        case .medium: "Poppins-Medium"
        default: "Poppins-Regular"
        }
    }
}

extension Font {
    static func poppins(
        _ size: CGFloat,
        weight: Font.Weight = .regular,
        relativeTo style: Font.TextStyle = .body
    ) -> Font {
        .custom(AppFont.name(for: weight), size: size, relativeTo: style)
    }
}
