import SwiftUI

enum Mood: String, CaseIterable, Identifiable {
    case sad
    case happy
    case calm
    case angry

    var id: Self { self }

    var title: String {
        rawValue.capitalized
    }

    var faceColor: Color {
        switch self {
        case .sad: Color(red: 0.60, green: 0.78, blue: 0.97)
        case .happy: Color(red: 0.97, green: 0.66, blue: 0.83)
        case .calm: Color(red: 0.55, green: 0.89, blue: 0.74)
        case .angry: Color(red: 0.98, green: 0.55, blue: 0.50)
        }
    }

    var cardBackground: Color {
        switch self {
        case .sad: Color(red: 0.88, green: 0.93, blue: 0.99)
        case .happy: Color(red: 0.99, green: 0.91, blue: 0.95)
        case .calm: Color(red: 0.86, green: 0.96, blue: 0.91)
        case .angry: Color(red: 0.99, green: 0.89, blue: 0.87)
        }
    }

    var accentColor: Color {
        switch self {
        case .sad: Color(red: 0.62, green: 0.78, blue: 0.97)
        case .happy: Color(red: 0.97, green: 0.64, blue: 0.81)
        case .calm: Color(red: 0.50, green: 0.88, blue: 0.69)
        case .angry: Color(red: 0.97, green: 0.58, blue: 0.55)
        }
    }

    var faceStyle: FaceStyle {
        self == .calm ? .serene : .classic
    }

    var mouthCurvature: CGFloat {
        switch self {
        case .happy: 0.34
        case .sad: -0.26
        case .angry: -0.12
        case .calm: 0.0
        }
    }

    var mouthDrop: CGFloat {
        switch self {
        case .sad: 0.12
        default: 0.0
        }
    }

    var showsBrows: Bool {
        self == .angry
    }
}

enum FaceStyle {
    case classic
    case serene
}

enum MoodPalette {
    static let surface = Color(red: 0.09, green: 0.09, blue: 0.10)
    static let chipBackground = Color(red: 0.16, green: 0.16, blue: 0.17)
    static let ink = Color.black
    static let worryAccent = Color(red: 0.56, green: 0.88, blue: 0.95)
}
