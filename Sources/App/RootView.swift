import SwiftUI

struct RootView: View {
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 160), spacing: 16)], spacing: 16) {
                    ForEach(Showcase.allCases) { showcase in
                        Button {
                            path.append(showcase)
                        } label: {
                            ShowcaseTile(showcase: showcase)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
            .background(BackgroundGradient())
            .navigationTitle("SwiftUI Lab")
            .navigationDestination(for: Showcase.self) { $0.destination }
        }
    }
}

enum Showcase: String, CaseIterable, Identifiable, Hashable {
    case liquidGlass = "Liquid Glass"
    case layouts = "Layouts & Grids"
    case forms = "Formularios"
    case animations = "Animaciones"
    case lists = "Listas Interactivas"
    case charts = "Gráficos"
    case moodCheckIn = "Mood Check-In"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .liquidGlass: "sparkles"
        case .layouts: "square.grid.2x2"
        case .forms: "checklist"
        case .animations: "wand.and.stars"
        case .lists: "list.bullet.rectangle"
        case .charts: "chart.bar.xaxis"
        case .moodCheckIn: "face.smiling"
        }
    }

    var tint: Color {
        switch self {
        case .liquidGlass: .cyan
        case .layouts: .orange
        case .forms: .green
        case .animations: .pink
        case .lists: .indigo
        case .charts: .purple
        case .moodCheckIn: .pink
        }
    }

    var subtitle: String {
        switch self {
        case .liquidGlass: "Efecto vidrio iOS 26"
        case .layouts: "LazyVGrid · Bento"
        case .forms: "Inputs validados"
        case .animations: "Springs · transiciones"
        case .lists: "Swipe · secciones"
        case .charts: "Swift Charts"
        case .moodCheckIn: "Onboarding · carrusel"
        }
    }

    @MainActor
    @ViewBuilder
    var destination: some View {
        switch self {
        case .liquidGlass: LiquidGlassShowcase()
        case .layouts: LayoutsShowcase()
        case .forms: FormsShowcase()
        case .animations: AnimationsShowcase()
        case .lists: ListsShowcase()
        case .charts: ChartsShowcase()
        case .moodCheckIn: MoodCheckInView()
        }
    }
}

private struct ShowcaseTile: View {
    let showcase: Showcase

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: showcase.icon)
                .font(.title)
                .foregroundStyle(showcase.tint)
                .frame(width: 52, height: 52)
                .background(showcase.tint.opacity(0.15), in: .rect(cornerRadius: 14))

            VStack(alignment: .leading, spacing: 2) {
                Text(showcase.rawValue)
                    .font(.headline)
                Text(showcase.subtitle)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 150, alignment: .topLeading)
        .padding()
        .glassTile()
    }
}

#Preview {
    RootView()
}
