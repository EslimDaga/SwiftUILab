import SwiftUI

struct CraftyoHomeView: View {
    enum TripType: String, CaseIterable, Identifiable {
        case oneWay = "One Way"
        case roundTrip = "Round Trip"
        case multiCity = "Multi City"
        var id: String { rawValue }
    }

    @State private var tripType: TripType = .oneWay
    @State private var origin = "Lima"
    @State private var destination = "La Paz"

    var body: some View {
        ZStack(alignment: .bottom) {
            skyBackdrop

            ScrollView(showsIndicators: false) {
                VStack(spacing: 0) {
                    headerZone
                    contentZone
                }
            }
            .ignoresSafeArea(edges: .top)

            CraftyoTabBar()
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }

    private var skyBackdrop: some View {
        Color.white
            .overlay(alignment: .top) {
                LinearGradient(
                    stops: [
                        .init(color: CraftyoTheme.skyStrong, location: 0.0),
                        .init(color: CraftyoTheme.skyMid, location: 0.35),
                        .init(color: CraftyoTheme.skyPale, location: 0.72),
                        .init(color: .white, location: 1.0)
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .frame(height: 540)
            }
            .ignoresSafeArea()
    }

    private var headerZone: some View {
        VStack(spacing: 24) {
            greetingRow
            searchCard
        }
        .padding(.horizontal, 20)
        .padding(.top, 64)
        .padding(.bottom, 28)
    }

    private var contentZone: some View {
        VStack(spacing: 28) {
            CouponSection()
            LastTripSection()
        }
        .padding(.top, 24)
        .padding(.bottom, 120)
    }

    private var greetingRow: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Hello Eslim!")
                    .font(.craftyo(15, weight: .regular))
                    .foregroundStyle(.white.opacity(0.92))
                Text("Ready for your next trip?")
                    .font(.craftyo(24, weight: .semibold))
                    .foregroundStyle(.white)
            }

            Spacer(minLength: 12)

            Button {
            } label: {
                Image(systemName: "bell")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundStyle(.white)
                    .frame(width: 48, height: 48)
                    .background(.white.opacity(0.15), in: .circle)
                    .overlay(alignment: .topTrailing) {
                        Text("5")
                            .font(.system(size: 11, weight: .bold))
                            .foregroundStyle(.white)
                            .frame(width: 20, height: 20)
                            .background(CraftyoTheme.badge, in: .circle)
                            .overlay(Circle().stroke(.white, lineWidth: 1.5))
                            .offset(x: 4, y: -4)
                    }
            }
            .buttonStyle(.plain)
            .accessibilityLabel("Notifications, 5 unread")
        }
    }

    private var searchCard: some View {
        VStack(spacing: 16) {
            tripTypeSelector
            routeRow
            dateField
            passengerClassRow
            searchButton
        }
        .padding(16)
        .background(CraftyoTheme.card, in: .rect(cornerRadius: 28))

    }

    private var tripTypeSelector: some View {
        HStack(spacing: 0) {
            ForEach(TripType.allCases) { type in
                let selected = tripType == type
                Text(type.rawValue)
                    .font(.craftyo(15, weight: selected ? .semibold : .regular))
                    .foregroundStyle(selected ? CraftyoTheme.textPrimary : CraftyoTheme.textSecondary)
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 12)
                    .background {
                        if selected {
                            Capsule()
                                .fill(CraftyoTheme.card)
                                .shadow(color: .black.opacity(0.06), radius: 6, x: 0, y: 2)
                        }
                    }
                    .contentShape(.rect)
                    .onTapGesture {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.85)) {
                            tripType = type
                        }
                    }
            }
        }
        .padding(4)
        .background(CraftyoTheme.segmentTrack, in: .capsule)
    }

    private var routeRow: some View {
        HStack(spacing: 8) {
            cityField(icon: "airplane.departure", value: origin)
            swapButton
            cityField(icon: "airplane.arrival", value: destination)
        }
    }

    private var swapButton: some View {
        Button {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.8)) {
                swap(&origin, &destination)
            }
        } label: {
            Image(systemName: "arrow.left.arrow.right")
                .font(.system(size: 13, weight: .bold))
                .foregroundStyle(.white)
                .frame(width: 38, height: 38)
                .background(CraftyoTheme.navy, in: .rect(cornerRadius: 12))

        }
        .buttonStyle(.plain)
        .accessibilityLabel("Swap origin and destination")
    }

    private func cityField(icon: String, value: String) -> some View {
        HStack(spacing: 8) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(CraftyoTheme.navy)
            Text(value)
                .font(.craftyo(15, weight: .medium))
                .foregroundStyle(CraftyoTheme.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.8)
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 16)
        .craftyoInput()
    }

    private var dateField: some View {
        HStack(spacing: 10) {
            Image(systemName: "calendar")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(CraftyoTheme.navy)
            Text("Mon, 08 Jun 2026")
                .font(.craftyo(15, weight: .medium))
                .foregroundStyle(CraftyoTheme.textPrimary)
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 16)
        .craftyoInput()
    }

    private var passengerClassRow: some View {
        HStack(spacing: 12) {
            iconField(icon: "person", value: "1 Adult")
            iconField(icon: "cube", value: "Economy")
        }
    }

    private func iconField(icon: String, value: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(CraftyoTheme.navy)
            Text(value)
                .font(.craftyo(15, weight: .medium))
                .foregroundStyle(CraftyoTheme.textPrimary)
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 16)
        .craftyoInput()
    }

    private var searchButton: some View {
        Button {
        } label: {
            Text("Search Flights")
                .font(.craftyo(17, weight: .semibold))
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 18)
                .background(
                    LinearGradient(
                        colors: [CraftyoTheme.navy, CraftyoTheme.navyDeep],
                        startPoint: .top,
                        endPoint: .bottom
                    ),
                    in: .capsule
                )
        }
        .buttonStyle(.plain)
    }
}

private struct CraftyoInputBackground: ViewModifier {
    var corner: CGFloat = 12

    func body(content: Content) -> some View {
        content
            .background(CraftyoTheme.card, in: .rect(cornerRadius: corner))
            .overlay(RoundedRectangle(cornerRadius: corner).stroke(CraftyoTheme.inputStroke, lineWidth: 1))
    }
}

private extension View {
    func craftyoInput(corner: CGFloat = 20) -> some View {
        modifier(CraftyoInputBackground(corner: corner))
    }
}

#Preview {
    CraftyoHomeView()
}
