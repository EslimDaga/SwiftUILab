import SwiftUI

struct PayviaOnboardingView: View {
    var onContinue: () -> Void = {}

    private let pageCount = 3
    private let headlineLines = ["Smart Finance", "for Everyday", "Life."]
    @State private var currentPage = 0
    @State private var appeared = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
            Color.clear.payviaBackground()

            globe
                .accessibilityHidden(true)

            VStack(alignment: .leading, spacing: 0) {
                PayviaWordmark(size: 22)
                    .padding(.top, 4)
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : -14)
                    .animation(.spring(response: 0.6, dampingFraction: 0.85).delay(0.05), value: appeared)

                Spacer(minLength: 0)

                pageIndicator
                    .padding(.bottom, 22)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.5).delay(0.25), value: appeared)

                headline

                Spacer().frame(height: 32)

                actions
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .onAppear { appeared = true }
    }

    private var globe: some View {
        Image("PayviaGlobe")
            .resizable()
            .scaledToFit()
            .frame(width: 245)
            .background {
                PayviaTheme.violetBright
                    .mask(
                        Image("PayviaGlobe")
                            .resizable()
                            .scaledToFit()
                    )
                    .blur(radius: 59)
                    .offset(y: 6)
                    .opacity(appeared ? 1 : 0)
                    .animation(.easeOut(duration: 0.6).delay(0.15), value: appeared)
            }
            .offset(x: 2, y: 14)
            .scaleEffect(appeared ? 1 : 0.78, anchor: .topTrailing)
            .rotationEffect(.degrees(appeared ? 0 : -12))
            .opacity(appeared ? 1 : 0)
            .animation(.spring(response: 0.95, dampingFraction: 0.72).delay(0.1), value: appeared)
    }

    private var pageIndicator: some View {
        HStack(spacing: 6) {
            ForEach(0..<pageCount, id: \.self) { index in
                Capsule()
                    .fill(.white.opacity(index == currentPage ? 1 : 0.35))
                    .frame(width: index == currentPage ? 22 : 6, height: 6)
            }
        }
        .animation(.snappy, value: currentPage)
        .accessibilityElement()
        .accessibilityLabel("Página \(currentPage + 1) de \(pageCount)")
    }

    private var headline: some View {
        VStack(alignment: .leading, spacing: 2) {
            ForEach(Array(headlineLines.enumerated()), id: \.offset) { index, line in
                Text(line)
                    .opacity(appeared ? 1 : 0)
                    .offset(y: appeared ? 0 : 26)
                    .animation(
                        .spring(response: 0.7, dampingFraction: 0.85)
                            .delay(0.32 + Double(index) * 0.09),
                        value: appeared
                    )
            }
        }
        .font(.bricolage(46, weight: .black, relativeTo: .largeTitle))
        .foregroundStyle(.white)
        .lineSpacing(2)
        .fixedSize(horizontal: false, vertical: true)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("Smart Finance for Everyday Life")
        .accessibilityAddTraits(.isHeader)
    }

    private var actions: some View {
        VStack(spacing: 12) {
            HStack(spacing: 12) {
                filledButton("Login") {}
                filledButton("Register") {}
            }
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 30)
            .animation(.spring(response: 0.7, dampingFraction: 0.85).delay(0.58), value: appeared)

            Button(action: onContinue) {
                HStack(spacing: 8) {
                    Image(systemName: "apple.logo")
                        .font(.system(size: 17, weight: .medium))
                    Text("Continue with Apple")
                        .font(.bricolage(17, weight: .semibold, relativeTo: .body))
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .overlay {
                    Capsule().strokeBorder(.white.opacity(0.55), lineWidth: 1.5)
                }
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Continuar con Apple")
            .opacity(appeared ? 1 : 0)
            .offset(y: appeared ? 0 : 30)
            .animation(.spring(response: 0.7, dampingFraction: 0.85).delay(0.66), value: appeared)
        }
    }

    private func filledButton(_ title: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.bricolage(17, weight: .semibold, relativeTo: .body))
                .foregroundStyle(PayviaTheme.ink)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(.white, in: .capsule)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    PayviaOnboardingView()
}
