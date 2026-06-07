import SwiftUI

struct BackgroundGradient: View {
    var body: some View {
        LinearGradient(
            colors: [Color(.systemBackground), Color.accentColor.opacity(0.12)],
            startPoint: .top,
            endPoint: .bottom
        )
        .ignoresSafeArea()
    }
}

private struct GlassTileModifier: ViewModifier {
    var cornerRadius: CGFloat = 18

    func body(content: Content) -> some View {
        if #available(iOS 26, *) {
            content.glassEffect(.regular, in: .rect(cornerRadius: cornerRadius))
        } else {
            content.background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: cornerRadius))
        }
    }
}

extension View {
    func glassTile(cornerRadius: CGFloat = 18) -> some View {
        modifier(GlassTileModifier(cornerRadius: cornerRadius))
    }
}
