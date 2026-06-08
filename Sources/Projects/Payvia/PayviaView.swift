import SwiftUI

struct PayviaView: View {
    private enum Screen { case splash, onboarding, home }

    @State private var screen: Screen = .splash

    var body: some View {
        ZStack {
            switch screen {
            case .splash:
                PayviaSplashView()
                    .transition(.opacity)
            case .onboarding:
                PayviaOnboardingView(onContinue: goHome)
                    .transition(.identity)
            case .home:
                PayviaHomeView()
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            }
        }
        .preferredColorScheme(.dark)
        .toolbarVisibility(.hidden, for: .navigationBar)
        .task {
            try? await _Concurrency.Task.sleep(for: .seconds(1.8))
            withAnimation(.easeInOut(duration: 0.5)) {
                screen = .onboarding
            }
        }
    }

    private func goHome() {
        withAnimation(.spring(response: 0.55, dampingFraction: 0.85)) {
            screen = .home
        }
    }
}

#Preview {
    PayviaView()
}
