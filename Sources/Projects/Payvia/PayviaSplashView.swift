import SwiftUI

struct PayviaSplashView: View {
    @State private var appeared = false

    var body: some View {
        ZStack {
            PayviaTheme.brand.ignoresSafeArea()

            PayviaWordmark(
                size: 60,
                markTrim: appeared ? 1 : 0,
                markProgress: appeared ? 1 : 0
            )
            .opacity(appeared ? 1 : 0)
            .scaleEffect(appeared ? 1 : 0.9)
            .blur(radius: appeared ? 0 : 8)
            .animation(.spring(response: 0.7, dampingFraction: 0.82), value: appeared)
        }
        .onAppear { appeared = true }
    }
}

#Preview {
    PayviaSplashView()
}
