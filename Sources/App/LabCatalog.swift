import SwiftUI

struct LabProject: Identifiable {
    let id: String
    let title: String
    let designer: String
    let summary: String
    let accent: Color
    let symbol: String
    let added: String
    let destination: () -> AnyView
}

struct LabShowcase: Identifiable {
    let id: String
    let title: String
    let symbol: String
    let destination: () -> AnyView
}

enum LabRoute: Hashable {
    case project(String)
    case showcase(String)
}

@MainActor
enum LabCatalog {
    static let projects: [LabProject] = [
        LabProject(
            id: "payvia",
            title: "Payvia",
            designer: "Finance Mobile App",
            summary: "Splash y onboarding de una fintech con tipografía Bricolage Grotesque y fondo azul eléctrico.",
            accent: PayviaTheme.brand,
            symbol: "creditcard.fill",
            added: "Jun 2026",
            destination: { AnyView(PayviaView()) }
        ),
        LabProject(
            id: "mood-check-in",
            title: "Mood Check-In",
            designer: "Self-care onboarding",
            summary: "Onboarding de bienestar con selección de ánimo animada y caras expresivas.",
            accent: .purple,
            symbol: "face.smiling.inverse",
            added: "Jun 2026",
            destination: { AnyView(MoodCheckInView()) }
        )
    ]

    static let showcases: [LabShowcase] = [
        LabShowcase(id: "animations", title: "Animations", symbol: "wand.and.stars") { AnyView(AnimationsShowcase()) },
        LabShowcase(id: "lists", title: "Lists", symbol: "list.bullet.rectangle") { AnyView(ListsShowcase()) },
        LabShowcase(id: "charts", title: "Charts", symbol: "chart.xyaxis.line") { AnyView(ChartsShowcase()) },
        LabShowcase(id: "forms", title: "Forms", symbol: "square.and.pencil") { AnyView(FormsShowcase()) },
        LabShowcase(id: "layouts", title: "Layouts", symbol: "rectangle.3.group") { AnyView(LayoutsShowcase()) },
        LabShowcase(id: "liquid-glass", title: "Liquid Glass", symbol: "drop.halffull") { AnyView(LiquidGlassShowcase()) }
    ]

    static func project(id: String) -> LabProject? {
        projects.first { $0.id == id }
    }

    static func showcase(id: String) -> LabShowcase? {
        showcases.first { $0.id == id }
    }
}
