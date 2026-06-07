import SwiftUI

struct AnimationsShowcase: View {
    @State private var expanded = false
    @State private var showBadge = false
    @Namespace private var glassNamespace

    var body: some View {
        ScrollView {
            VStack(spacing: 28) {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Spring + matchedGeometry")
                        .font(.headline)
                    ZStack(alignment: expanded ? .bottomTrailing : .topLeading) {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(.quaternary)
                            .frame(height: 140)
                        Circle()
                            .fill(.pink.gradient)
                            .matchedGeometryEffect(id: "ball", in: glassNamespace)
                            .frame(width: 56, height: 56)
                            .padding()
                    }
                    .onTapGesture {
                        withAnimation(.spring(duration: 0.6, bounce: 0.5)) {
                            expanded.toggle()
                        }
                    }
                    Text("Toca la tarjeta")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                VStack(spacing: 12) {
                    Text("Transiciones")
                        .font(.headline)
                    Button("Toggle badge") {
                        withAnimation(.bouncy) { showBadge.toggle() }
                    }
                    .buttonStyle(.bordered)
                    if showBadge {
                        Label("¡Nuevo!", systemImage: "sparkles")
                            .padding(.horizontal, 16).padding(.vertical, 8)
                            .background(.yellow.gradient, in: .capsule)
                            .transition(.scale.combined(with: .opacity))
                    }
                }

                VStack(spacing: 12) {
                    Text("PhaseAnimator")
                        .font(.headline)
                    Image(systemName: "bell.fill")
                        .font(.system(size: 44))
                        .foregroundStyle(.orange)
                        .phaseAnimator([0, -15, 15, 0]) { content, angle in
                            content.rotationEffect(.degrees(angle), anchor: .top)
                        } animation: { _ in .easeInOut(duration: 0.3) }
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
        }
        .background(BackgroundGradient())
        .navigationTitle("Animaciones")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack { AnimationsShowcase() }
}
