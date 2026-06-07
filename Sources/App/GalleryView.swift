import SwiftUI


struct GalleryView: View {
    private let columns = [GridItem(.adaptive(minimum: 150), spacing: 16)]

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 32) {
                    projectsSection
                    showcasesSection
                }
                .padding(20)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("SwiftUI Lab")
            .navigationDestination(for: LabRoute.self) { route in
                switch route {
                case .project(let id):
                    if let project = LabCatalog.project(id: id) {
                        project.destination()
                    }
                case .showcase(let id):
                    if let showcase = LabCatalog.showcase(id: id) {
                        showcase.destination()
                            .navigationTitle(showcase.title)
                            .navigationBarTitleDisplayMode(.inline)
                    }
                }
            }
        }
    }

    private var projectsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Recreaciones", subtitle: "Diseños de Dribbble reconstruidos en SwiftUI")

            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(LabCatalog.projects) { project in
                    NavigationLink(value: LabRoute.project(project.id)) {
                        ProjectCard(project: project)
                    }
                    .buttonStyle(.plain)
                    .accessibilityHint("Abre la recreación \(project.title)")
                }
            }
        }
    }

    private var showcasesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            sectionHeader("Showcases", subtitle: "Demos reutilizables de SwiftUI, compartidos entre proyectos")

            VStack(spacing: 0) {
                ForEach(Array(LabCatalog.showcases.enumerated()), id: \.element.id) { index, showcase in
                    NavigationLink(value: LabRoute.showcase(showcase.id)) {
                        ShowcaseRow(showcase: showcase)
                    }
                    .buttonStyle(.plain)

                    if index < LabCatalog.showcases.count - 1 {
                        Divider().padding(.leading, 56)
                    }
                }
            }
            .background(Color(.secondarySystemGroupedBackground), in: .rect(cornerRadius: 16))
        }
    }

    private func sectionHeader(_ title: String, subtitle: String) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.poppins(20, weight: .bold, relativeTo: .title3))
            Text(subtitle)
                .font(.poppins(13, relativeTo: .footnote))
                .foregroundStyle(.secondary)
        }
        .accessibilityElement(children: .combine)
    }
}

private struct ProjectCard: View {
    let project: LabProject

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            RoundedRectangle(cornerRadius: 16)
                .fill(project.accent.gradient)
                .frame(height: 96)
                .overlay {
                    Image(systemName: project.symbol)
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(.white)
                }

            VStack(alignment: .leading, spacing: 4) {
                Text(project.title)
                    .font(.poppins(16, weight: .semibold, relativeTo: .headline))
                Text(project.designer)
                    .font(.poppins(12, relativeTo: .caption))
                    .foregroundStyle(.secondary)
            }

            Text(project.added)
                .font(.poppins(11, relativeTo: .caption2))
                .foregroundStyle(.tertiary)
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemGroupedBackground), in: .rect(cornerRadius: 20))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(project.title), \(project.designer)")
    }
}

private struct ShowcaseRow: View {
    let showcase: LabShowcase

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: showcase.symbol)
                .font(.system(size: 18, weight: .semibold))
                .foregroundStyle(.tint)
                .frame(width: 28)

            Text(showcase.title)
                .font(.poppins(15, weight: .medium, relativeTo: .body))

            Spacer()

            Image(systemName: "chevron.right")
                .font(.system(size: 13, weight: .semibold))
                .foregroundStyle(.tertiary)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 14)
        .contentShape(.rect)
    }
}

#Preview {
    GalleryView()
}
