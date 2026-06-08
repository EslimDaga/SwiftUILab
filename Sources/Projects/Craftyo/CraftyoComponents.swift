import SwiftUI

struct CraftyoSectionHeader: View {
    let title: String

    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            Text(title)
                .font(.craftyo(20, weight: .semibold))
                .foregroundStyle(CraftyoTheme.textPrimary)
            Spacer()
            Button("See All") {}
                .font(.craftyo(14, weight: .medium))
                .foregroundStyle(CraftyoTheme.accent)
                .buttonStyle(.plain)
        }
        .padding(.horizontal, 20)
    }
}

struct CraftyoAirlineMark: View {
    let tint: Color
    var corner: CGFloat = 14
    var size: CGFloat = 44

    var body: some View {
        Image(systemName: "airplane")
            .font(.system(size: size * 0.42, weight: .semibold))
            .foregroundStyle(tint)
            .frame(width: size, height: size)
            .background(tint.opacity(0.12), in: .rect(cornerRadius: corner))
    }
}

struct CouponSection: View {
    private struct Coupon: Identifiable {
        let id = UUID()
        let amount: String
        let detail: String
        let code: String
        let tint: Color
    }

    private let coupons = [
        Coupon(amount: "Save $100 USD", detail: "For Garuda Indonesia Flight", code: "CANSASFLIGHT", tint: CraftyoTheme.garuda),
        Coupon(amount: "Save $75 USD", detail: "For Lion Air Flight", code: "CANSASLION", tint: CraftyoTheme.lion)
    ]

    var body: some View {
        VStack(spacing: 16) {
            CraftyoSectionHeader(title: "Your Coupon")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(coupons) { coupon in
                        couponCard(coupon)
                            .containerRelativeFrame(.horizontal) { width, _ in width * 0.84 }
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 20)
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }

    private func couponCard(_ coupon: Coupon) -> some View {
        VStack(spacing: 14) {
            HStack(spacing: 14) {
                CraftyoAirlineMark(tint: coupon.tint)
                VStack(alignment: .leading, spacing: 4) {
                    Text(coupon.amount)
                        .font(.craftyo(18, weight: .semibold))
                        .foregroundStyle(CraftyoTheme.textPrimary)
                    Text(coupon.detail)
                        .font(.craftyo(13, weight: .regular))
                        .foregroundStyle(CraftyoTheme.textSecondary)
                }
                Spacer(minLength: 0)
            }

            Line()
                .stroke(style: StrokeStyle(lineWidth: 1, dash: [5, 5]))
                .foregroundStyle(CraftyoTheme.stroke)
                .frame(height: 1)

            HStack(spacing: 12) {
                Text(coupon.code)
                    .font(.craftyo(13, weight: .regular))
                    .foregroundStyle(CraftyoTheme.textSecondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 14)
                    .padding(.vertical, 12)
                    .background(CraftyoTheme.field, in: .rect(cornerRadius: 12))

                Button("Copy") {}
                    .font(.craftyo(14, weight: .medium))
                    .foregroundStyle(CraftyoTheme.accent)
                    .buttonStyle(.plain)
            }
        }
        .padding(18)
        .background(CraftyoTheme.card, in: .rect(cornerRadius: 22))
        .overlay(RoundedRectangle(cornerRadius: 22).stroke(CraftyoTheme.stroke, lineWidth: 1))
    }
}

struct LastTripSection: View {
    private struct Trip: Identifiable {
        let id = UUID()
        let airline: String
        let date: String
        let tint: Color
    }

    private let trips = [
        Trip(airline: "United Airlines", date: "28 November 2025", tint: CraftyoTheme.united),
        Trip(airline: "Scoot", date: "12 December 2025", tint: CraftyoTheme.scoot)
    ]

    var body: some View {
        VStack(spacing: 16) {
            CraftyoSectionHeader(title: "Last Trip")

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(trips) { trip in
                        tripCard(trip)
                            .containerRelativeFrame(.horizontal) { width, _ in width * 0.84 }
                    }
                }
                .scrollTargetLayout()
                .padding(.horizontal, 20)
            }
            .scrollTargetBehavior(.viewAligned)
        }
    }

    private func tripCard(_ trip: Trip) -> some View {
        HStack(spacing: 14) {
            CraftyoAirlineMark(tint: trip.tint, corner: 12, size: 48)
            VStack(alignment: .leading, spacing: 4) {
                Text(trip.airline)
                    .font(.craftyo(17, weight: .semibold))
                    .foregroundStyle(CraftyoTheme.textPrimary)
                Text(trip.date)
                    .font(.craftyo(13, weight: .regular))
                    .foregroundStyle(CraftyoTheme.textSecondary)
            }
            Spacer(minLength: 0)
            Image(systemName: "chevron.right")
                .font(.system(size: 14, weight: .semibold))
                .foregroundStyle(CraftyoTheme.textSecondary)
        }
        .padding(18)
        .background(CraftyoTheme.card, in: .rect(cornerRadius: 22))
        .overlay(RoundedRectangle(cornerRadius: 22).stroke(CraftyoTheme.stroke, lineWidth: 1))
    }
}

struct CraftyoTabBar: View {
    private struct Item: Identifiable {
        let id = UUID()
        let title: String
        let symbol: String
    }

    @State private var selected = "Home"

    private let items = [
        Item(title: "Home", symbol: "house.fill"),
        Item(title: "My Trips", symbol: "suitcase.fill"),
        Item(title: "Wishlist", symbol: "heart"),
        Item(title: "Inbox", symbol: "bubble.left.and.bubble.right"),
        Item(title: "Profile", symbol: "person")
    ]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(items) { item in
                let active = selected == item.title
                Button {
                    selected = item.title
                } label: {
                    VStack(spacing: 6) {
                        Image(systemName: item.symbol)
                            .font(.system(size: 20, weight: active ? .semibold : .regular))
                        Text(item.title)
                            .font(.craftyo(11, weight: active ? .medium : .regular))
                    }
                    .foregroundStyle(active ? CraftyoTheme.navy : CraftyoTheme.textSecondary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 12)
        .padding(.top, 12)
        .padding(.bottom, 4)
        .background(
            CraftyoTheme.card
                .ignoresSafeArea(edges: .bottom)
                .shadow(color: .black.opacity(0.06), radius: 16, x: 0, y: -4)
        )
    }
}

private struct Line: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        return path
    }
}

#Preview {
    ZStack(alignment: .bottom) {
        CraftyoTheme.canvas.ignoresSafeArea()
        ScrollView {
            VStack(spacing: 28) {
                CouponSection()
                LastTripSection()
            }
            .padding(.vertical, 24)
        }
        CraftyoTabBar()
    }
}
