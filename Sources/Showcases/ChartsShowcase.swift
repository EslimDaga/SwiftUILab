import SwiftUI
import Charts

struct SalesPoint: Identifiable {
    let id = UUID()
    let month: String
    let value: Double
    let category: String
}

struct ChartsShowcase: View {
    private let monthly: [SalesPoint] = [
        .init(month: "Ene", value: 120, category: "2025"),
        .init(month: "Feb", value: 180, category: "2025"),
        .init(month: "Mar", value: 140, category: "2025"),
        .init(month: "Abr", value: 220, category: "2025"),
        .init(month: "May", value: 260, category: "2025"),
        .init(month: "Jun", value: 300, category: "2025"),
    ]

    private let share: [SalesPoint] = [
        .init(month: "iOS", value: 55, category: "platform"),
        .init(month: "Android", value: 30, category: "platform"),
        .init(month: "Web", value: 15, category: "platform"),
    ]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                chartCard("Barras") {
                    Chart(monthly) { point in
                        BarMark(x: .value("Mes", point.month),
                                y: .value("Ventas", point.value))
                            .foregroundStyle(.purple.gradient)
                            .cornerRadius(6)
                    }
                    .frame(height: 200)
                }

                chartCard("Línea + área") {
                    Chart(monthly) { point in
                        AreaMark(x: .value("Mes", point.month),
                                 y: .value("Ventas", point.value))
                            .foregroundStyle(.pink.opacity(0.2).gradient)
                        LineMark(x: .value("Mes", point.month),
                                 y: .value("Ventas", point.value))
                            .foregroundStyle(.pink)
                            .symbol(.circle)
                            .interpolationMethod(.catmullRom)
                    }
                    .frame(height: 200)
                }

                chartCard("Sectores") {
                    Chart(share) { point in
                        SectorMark(angle: .value("Cuota", point.value),
                                   innerRadius: .ratio(0.55),
                                   angularInset: 2)
                            .foregroundStyle(by: .value("Plataforma", point.month))
                            .cornerRadius(4)
                    }
                    .frame(height: 220)
                }
            }
            .padding()
        }
        .background(BackgroundGradient())
        .navigationTitle("Gráficos")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func chartCard<Content: View>(_ title: String,
                                          @ViewBuilder content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title).font(.headline)
            content()
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassTile()
    }
}

#Preview {
    NavigationStack { ChartsShowcase() }
}
