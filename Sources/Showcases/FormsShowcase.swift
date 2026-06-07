import SwiftUI

@Observable
@MainActor
final class SignUpModel {
    var name = ""
    var email = ""
    var plan = Plan.basic
    var notifications = true
    var experience = 3.0

    enum Plan: String, CaseIterable, Identifiable {
        case basic = "Básico", pro = "Pro", team = "Equipo"
        var id: String { rawValue }
    }

    var emailIsValid: Bool {
        email.contains("@") && email.contains(".")
    }

    var isValid: Bool {
        !name.isEmpty && emailIsValid
    }
}

struct FormsShowcase: View {
    @State private var model = SignUpModel()
    @State private var submitted = false

    var body: some View {
        Form {
            Section("Datos personales") {
                TextField("Nombre", text: $model.name)
                    .textContentType(.name)
                TextField("Correo", text: $model.email)
                    .textContentType(.emailAddress)
                    .keyboardType(.emailAddress)
                    .autocorrectionDisabled()
                if !model.email.isEmpty && !model.emailIsValid {
                    Label("Correo no válido", systemImage: "exclamationmark.triangle")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }

            Section("Preferencias") {
                Picker("Plan", selection: $model.plan) {
                    ForEach(SignUpModel.Plan.allCases) { Text($0.rawValue).tag($0) }
                }
                Toggle("Notificaciones", isOn: $model.notifications)
                VStack(alignment: .leading) {
                    Text("Experiencia: \(Int(model.experience)) años")
                    Slider(value: $model.experience, in: 0...10, step: 1)
                }
            }

            Section {
                Button {
                    submitted = true
                } label: {
                    Text("Registrarse")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(.borderedProminent)
                .disabled(!model.isValid)
            }
        }
        .navigationTitle("Formularios")
        .navigationBarTitleDisplayMode(.inline)
        .alert("¡Registrado!", isPresented: $submitted) {
            Button("OK", role: .cancel) {}
        } message: {
            Text("Bienvenido, \(model.name) · Plan \(model.plan.rawValue)")
        }
    }
}

#Preview {
    NavigationStack { FormsShowcase() }
}
