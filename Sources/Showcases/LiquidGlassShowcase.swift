import SwiftUI

struct LiquidGlassShowcase: View {
    @State private var isOn = true

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                GlassCard(
                    title: "Liquid Glass",
                    subtitle: "Material translúcido y dinámico introducido en iOS 26."
                )

                GlassCard(
                    title: "Adaptativo",
                    subtitle: "Refracta el contenido que tiene detrás y se adapta al fondo."
                )

                if #available(iOS 26, *) {
                    GlassEffectContainer(spacing: 16) {
                        HStack(spacing: 16) {
                            glassButton("heart.fill", tint: .pink)
                            glassButton("star.fill", tint: .yellow)
                            glassButton("bolt.fill", tint: .blue)
                        }
                    }
                }

                Toggle("Activar destacado", isOn: $isOn)
                    .padding()
                    .glassTile()
            }
            .padding()
        }
        .background(
            LinearGradient(colors: [.indigo, .cyan, .teal],
                           startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        )
        .navigationTitle("Liquid Glass")
        .navigationBarTitleDisplayMode(.inline)
    }

    @available(iOS 26, *)
    private func glassButton(_ symbol: String, tint: Color) -> some View {
        Image(systemName: symbol)
            .font(.title2)
            .foregroundStyle(tint)
            .frame(width: 60, height: 60)
            .glassEffect(.regular.interactive(), in: .circle)
    }
}

struct GlassCard: View {
    let title: String
    let subtitle: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title3.bold())
            Text(subtitle)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .glassTile(cornerRadius: 20)
        .foregroundStyle(.white)
    }
}

#Preview {
    NavigationStack { LiquidGlassShowcase() }
}
