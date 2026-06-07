import SwiftUI

struct LayoutsShowcase: View {
    private let palette: [Color] = [.orange, .pink, .purple, .indigo, .teal, .mint, .blue, .red]

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                sectionTitle("Bento Grid")
                LazyVGrid(columns: [GridItem(.flexible(), spacing: 12),
                                    GridItem(.flexible(), spacing: 12)], spacing: 12) {
                    bentoCell(0, height: 120)
                    bentoCell(1, height: 180)
                    bentoCell(2, height: 180)
                    bentoCell(3, height: 120)
                }

                sectionTitle("Carrusel horizontal")
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 14) {
                        ForEach(0..<8) { index in
                            RoundedRectangle(cornerRadius: 18)
                                .fill(palette[index % palette.count].gradient)
                                .frame(width: 140, height: 100)
                                .overlay(
                                    Text("#\(index + 1)")
                                        .font(.title.bold())
                                        .foregroundStyle(.white)
                                )
                        }
                    }
                    .padding(.horizontal, 2)
                }

                sectionTitle("Grid adaptativo")
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70), spacing: 10)], spacing: 10) {
                    ForEach(0..<12) { index in
                        Circle()
                            .fill(palette[index % palette.count].gradient)
                            .frame(height: 70)
                    }
                }
            }
            .padding()
        }
        .background(BackgroundGradient())
        .navigationTitle("Layouts & Grids")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func sectionTitle(_ text: String) -> some View {
        Text(text)
            .font(.headline)
            .foregroundStyle(.secondary)
    }

    private func bentoCell(_ index: Int, height: CGFloat) -> some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(palette[index % palette.count].gradient)
            .frame(height: height)
            .overlay(alignment: .bottomLeading) {
                Image(systemName: "square.grid.2x2")
                    .font(.title)
                    .foregroundStyle(.white.opacity(0.9))
                    .padding()
            }
    }
}

#Preview {
    NavigationStack { LayoutsShowcase() }
}
