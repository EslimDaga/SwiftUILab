import SwiftUI

struct Task: Identifiable, Hashable {
    let id = UUID()
    var title: String
    var done = false
    var priority: Priority

    enum Priority: String, CaseIterable {
        case high = "Alta", medium = "Media", low = "Baja"
        var color: Color {
            switch self {
            case .high: .red
            case .medium: .orange
            case .low: .green
            }
        }
    }
}

struct ListsShowcase: View {
    @State private var tasks: [Task] = [
        Task(title: "Diseñar la pantalla de inicio", priority: .high),
        Task(title: "Revisar Liquid Glass", priority: .medium),
        Task(title: "Escribir tests", done: true, priority: .low),
        Task(title: "Configurar CI", priority: .medium),
    ]

    var body: some View {
        List {
            Section("Pendientes") {
                ForEach($tasks) { $task in
                    HStack {
                        Button {
                            withAnimation { task.done.toggle() }
                        } label: {
                            Image(systemName: task.done ? "checkmark.circle.fill" : "circle")
                                .foregroundStyle(task.done ? .green : .secondary)
                        }
                        .buttonStyle(.plain)

                        Text(task.title)
                            .strikethrough(task.done)
                            .foregroundStyle(task.done ? .secondary : .primary)

                        Spacer()

                        Text(task.priority.rawValue)
                            .font(.caption2.bold())
                            .padding(.horizontal, 8).padding(.vertical, 3)
                            .background(task.priority.color.opacity(0.2), in: .capsule)
                            .foregroundStyle(task.priority.color)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            tasks.removeAll { $0.id == task.id }
                        } label: { Label("Borrar", systemImage: "trash") }
                    }
                    .swipeActions(edge: .leading) {
                        Button {
                            withAnimation { task.done.toggle() }
                        } label: { Label("Hecho", systemImage: "checkmark") }
                        .tint(.green)
                    }
                }
                .onMove { tasks.move(fromOffsets: $0, toOffset: $1) }
                .onDelete { tasks.remove(atOffsets: $0) }
            }
        }
        .navigationTitle("Listas Interactivas")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) { EditButton() }
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    withAnimation {
                        tasks.insert(Task(title: "Nueva tarea", priority: .medium), at: 0)
                    }
                } label: { Image(systemName: "plus") }
            }
        }
    }
}

#Preview {
    NavigationStack { ListsShowcase() }
}
