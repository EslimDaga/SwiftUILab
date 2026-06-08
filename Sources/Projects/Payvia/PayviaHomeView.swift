import SwiftUI

struct PayviaHomeView: View {
    @State private var balanceHidden = false
    @State private var selectedTab: Tab = .home
    @State private var headerHeight: CGFloat = 320
    @State private var scrollY: CGFloat = 0

    enum Tab: Hashable { case home, statistic, wallet, settings }

    private let subtle = Color(red: 0.52, green: 0.54, blue: 0.58)
    private let inactive = Color(red: 0.62, green: 0.64, blue: 0.68)

    private let contacts: [(name: String, seed: String)] = [
        ("Noah", "Noah"), ("Mason", "Mason"), ("Oliver", "Oliver"),
        ("Lucas", "Lucas"), ("Ethan", "Ethan"),
    ]

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .top) {
                PayviaHeaderBackground()
                    .ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(spacing: 0) {
                        
                        Color.clear
                            .frame(height: 0)
                            .onGeometryChange(for: CGFloat.self) {
                                $0.frame(in: .named("scroll")).minY
                            } action: { scrollY = -$0 }

                        
                        header
                            .padding(.horizontal, 22)
                            .padding(.top, 8)
                            .onGeometryChange(for: CGFloat.self) { $0.size.height } action: { headerHeight = $0 }
                            .offset(y: max(scrollY, 0))
                            .opacity(1 - min(coverProgress * 1.25, 1))
                            .zIndex(0)

                        sheet
                            .frame(minHeight: geo.size.height)
                            .zIndex(1)
                    }
                }
                .coordinateSpace(name: "scroll")
            }
            // Pinned at the bottom without spanning (and intercepting) the
            // whole screen, so header/sheet controls above stay tappable.
            .overlay(alignment: .bottom) { tabBar }
        }
        .preferredColorScheme(.dark)
    }

    /// 0 when at rest, 1 once the sheet has risen far enough to fully cover the header.
    private var coverProgress: CGFloat {
        guard headerHeight > 0 else { return 0 }
        return min(max(scrollY, 0) / headerHeight, 1)
    }

    // MARK: Header (over the gradient)

    private var header: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(spacing: 12) {
                DiceBearAvatar(seed: "Oripio", size: 46, cornerRadius: 14)

                VStack(alignment: .leading, spacing: 0) {
                    Text("Good morning!")
                        .font(.bricolage(12.5, weight: .regular))
                        .foregroundStyle(.white.opacity(0.7))
                    Text("Eslim Daga")
                        .font(.bricolage(17, weight: .bold))
                        .foregroundStyle(.white)
                }

                Spacer(minLength: 8)

                circleIconButton(.search)
                circleIconButton(.bell, badge: true)
            }

            VStack(alignment: .leading, spacing: 6) {
                Text("Total Balance")
                    .font(.bricolage(13, weight: .medium))
                    .foregroundStyle(.white.opacity(0.72))

                HStack(alignment: .firstTextBaseline, spacing: 14) {
                    Text(balanceHidden ? "S/ • • • • •" : "S/56,893.30")
                        .font(.bricolage(33, weight: .black))
                        .foregroundStyle(.white)
                        .contentTransition(.interpolate)
                        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: balanceHidden)

                    Spacer(minLength: 0)

                    Button {
                        withAnimation(.spring(response: 0.35, dampingFraction: 0.75, blendDuration: 0)) {
                            balanceHidden.toggle()
                        }
                    } label: {
                        IconoirView(icon: balanceHidden ? .eyeClosed : .eye, size: 21)
                            .foregroundStyle(.white.opacity(0.85))
                            .frame(width: 44, height: 44)
                            .contentShape(.rect)
                    }
                    .buttonStyle(.plain)
                    .accessibilityLabel(balanceHidden ? "Mostrar saldo" : "Ocultar saldo")
                }

                HStack(spacing: 7) {
                    Text("**** **** 2329")
                        .font(.bricolage(13, weight: .medium))
                        .foregroundStyle(.white.opacity(0.7))
                        .tracking(1)
                    IconoirView(icon: .copy, size: 14)
                        .foregroundStyle(.white.opacity(0.7))
                }
            }

            HStack(spacing: 11) {
                actionButton("Deposit", icon: .plus, filled: false)
                actionButton("Transfer", icon: .transfer, filled: true)

                Button(action: {}) {
                    IconoirView(icon: .grid, size: 20)
                        .foregroundStyle(.white)
                        .frame(width: 52, height: 52)
                        .background(.white.opacity(0.16), in: .circle)
                }
                .buttonStyle(.plain)
                .accessibilityLabel("Más opciones")
            }

            Capsule()
                .fill(.white.opacity(0.85))
                .frame(width: 92, height: 5)
                .frame(maxWidth: .infinity)
                .padding(.bottom, 6)
        }
    }

    private func circleIconButton(_ icon: Iconoir, badge: Bool = false) -> some View {
        Button(action: {}) {
            IconoirView(icon: icon, size: 20)
                .foregroundStyle(.white)
                .frame(width: 44, height: 44)
                .background(.white.opacity(0.14), in: .circle)
                .overlay(alignment: .topTrailing) {
                    if badge {
                        Circle()
                            .fill(Color(red: 0.95, green: 0.27, blue: 0.27))
                            .frame(width: 8, height: 8)
                            .offset(x: -2, y: 2)
                    }
                }
        }
        .buttonStyle(.plain)
    }

    private func actionButton(_ title: String, icon: Iconoir, filled: Bool, action: @escaping () -> Void = {}) -> some View {
        Button(action: action) {
            HStack(spacing: 8) {
                IconoirView(icon: icon, size: 17)
                Text(title)
                    .font(.bricolage(15, weight: .semibold))
            }
            .foregroundStyle(filled ? .white : PayviaTheme.ink)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(filled ? AnyShapeStyle(PayviaTheme.brand) : AnyShapeStyle(.white), in: .capsule)
        }
        .buttonStyle(.plain)
    }


    private var sheet: some View {
        VStack(spacing: 24) {
            recentContacts
            transactions
            Spacer(minLength: 0)
        }
        .padding(.horizontal, 22)
        .padding(.top, 24)
        .padding(.bottom, 120)
        .frame(maxWidth: .infinity)
        .background {
            UnevenRoundedRectangle(topLeadingRadius: 32, topTrailingRadius: 32)
                .fill(Color.white)
        }
    }

    private var recentContacts: some View {
        VStack(spacing: 16) {
            sectionHeader("Recent Contacts")

            HStack(spacing: 0) {
                ForEach(contacts, id: \.seed) { contact in
                    contactColumn(contact.name, seed: contact.seed)
                }
            }

            HStack(spacing: 11) {
                pillButton("Add new", icon: .plus)
                pillButton("Manage Contact", icon: .edit)
            }
        }
        .padding(16)
        .background(Color(red: 0.95, green: 0.96, blue: 0.97), in: RoundedRectangle(cornerRadius: 24, style: .continuous))
    }

    private func contactColumn(_ name: String, seed: String) -> some View {
        VStack(spacing: 7) {
            DiceBearAvatar(seed: seed, size: 50)
            Text(name)
                .font(.bricolage(11.5, weight: .medium))
                .foregroundStyle(PayviaTheme.ink)
        }
        .frame(maxWidth: .infinity)
    }

    private func pillButton(_ title: String, icon: Iconoir) -> some View {
        Button(action: {}) {
            HStack(spacing: 7) {
                IconoirView(icon: icon, size: 16)
                Text(title)
                    .font(.bricolage(12, weight: .semibold))
            }
            .foregroundStyle(PayviaTheme.ink)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 13)
            .background(Color(red: 0.93, green: 0.94, blue: 0.95), in: .capsule)
        }
        .buttonStyle(.plain)
    }

    private var transactions: some View {
        VStack(alignment: .leading, spacing: 14) {
            sectionHeader("Transactions")

            Text("Today")
                .font(.bricolage(13, weight: .medium))
                .foregroundStyle(subtle)

            VStack(spacing: 20) {
                transactionRow(
                    logo: "logo-upwork",
                    title: "Upwork", subtitle: "Client Payment Received",
                    amount: "+S/480.00", positive: true, time: "Nov 4, 10:42 AM"
                )
                transactionRow(
                    logo: "logo-netflix",
                    title: "Netflix", subtitle: "Subscription Renewal",
                    amount: "-S/12.99", positive: false, time: "Nov 4, 09:20 AM"
                )
                transactionRow(
                    logo: "logo-starbucks",
                    title: "Starbucks", subtitle: "Morning Coffee",
                    amount: "-S/5.75", positive: false, time: "Nov 4, 08:13 AM"
                )
            }
        }
    }

    private func transactionRow(
        logo: String,
        title: String, subtitle: String,
        amount: String, positive: Bool, time: String
    ) -> some View {
        HStack(spacing: 13) {
            Image(logo)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 46, height: 46)
                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))

            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.bricolage(15, weight: .semibold))
                    .foregroundStyle(PayviaTheme.ink)
                Text(subtitle)
                    .font(.bricolage(12.5, weight: .regular))
                    .foregroundStyle(subtle)
            }

            Spacer(minLength: 8)

            VStack(alignment: .trailing, spacing: 2) {
                Text(amount)
                    .font(.bricolage(15, weight: .bold))
                    .foregroundStyle(positive
                        ? Color(red: 0.13, green: 0.70, blue: 0.40)
                        : Color(red: 0.93, green: 0.26, blue: 0.26))
                Text(time)
                    .font(.bricolage(12, weight: .regular))
                    .foregroundStyle(subtle)
            }
        }
        .accessibilityElement(children: .combine)
    }

    private func sectionHeader(_ title: String) -> some View {
        HStack {
            Text(title)
                .font(.bricolage(17, weight: .bold))
                .foregroundStyle(PayviaTheme.ink)
            Spacer()
            Button(action: {}) {
                HStack(spacing: 3) {
                    Text("See all")
                        .font(.bricolage(13, weight: .medium))
                    IconoirView(icon: .chevronRight, size: 14)
                }
                .foregroundStyle(PayviaTheme.ink.opacity(0.6))
            }
            .buttonStyle(.plain)
        }
    }

    // MARK: Tab bar

    private var tabBar: some View {
        ZStack {
            HStack {
                tabItem(.home, .home, "Home")
                tabItem(.statistic, .stats, "Statistic")
                Spacer().frame(width: 60)
                tabItem(.wallet, .wallet, "Wallet")
                tabItem(.settings, .settings, "Settings")
            }
            .padding(.horizontal, 22)
            .padding(.top, 12)
            .padding(.bottom, 6)
            .background {
                Color.white
                    .ignoresSafeArea(edges: .bottom)
                    .shadow(color: .black.opacity(0.06), radius: 12, y: -4)
            }

            Button(action: {}) {
                IconoirView(icon: .scan, size: 26)
                    .foregroundStyle(.white)
                    .frame(width: 58, height: 58)
                    .background(PayviaTheme.brand, in: .circle)
                    .shadow(color: PayviaTheme.brand.opacity(0.35), radius: 10, y: 4)
            }
            .buttonStyle(.plain)
            .padding(7)
            .background {
                Circle()
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.06), radius: 10, y: -3)
            }
            .offset(y: -22)
            .accessibilityLabel("Escanear")
        }
    }

    private func tabItem(_ tab: Tab, _ icon: Iconoir, _ label: String) -> some View {
        let active = selectedTab == tab
        return Button {
            selectedTab = tab
        } label: {
            VStack(spacing: 4) {
                IconoirView(icon: icon, size: 22)
                Text(label)
                    .font(.bricolage(10.5, weight: active ? .semibold : .medium))
            }
            .foregroundStyle(active ? PayviaTheme.brand : inactive)
            .frame(maxWidth: .infinity)
        }
        .buttonStyle(.plain)
    }
}

/// Vertical navy→cobalt→ice-blue gradient with a fine film grain blended in
/// `softLight`, ported from the reference CSS:
/// `linear-gradient(180deg, #05091E 0%, #1A42E6 70%, #D0F4FF 100%)`
/// plus a fractal-noise overlay (`background-blend-mode: soft-light`).
struct PayviaHeaderBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                stops: [
                    .init(color: Color(red: 0.0196, green: 0.0353, blue: 0.1176), location: 0.0),  // #05091E
                    .init(color: Color(red: 0.1020, green: 0.2588, blue: 0.9020), location: 0.70),  // #1A42E6
                    .init(color: Color(red: 0.8157, green: 0.9569, blue: 1.0000), location: 1.0),   // #D0F4FF
                ],
                startPoint: .top,
                endPoint: .bottom
            )

            PayviaNoise.image
                .resizable(resizingMode: .tile)
                .opacity(0.06)
                .blendMode(.softLight)
                .allowsHitTesting(false)
        }
        .compositingGroup()
    }
}

/// A small tileable monochrome white-noise texture, generated once. Tiled and
/// blended with `softLight` it reads as a subtle, even film grain over the
/// gradient (pure white noise tiles seamlessly — no visible repetition).
enum PayviaNoise {
    static let image: Image = {
        let dim = 160
        let bytesPerRow = dim * 4
        var pixels = [UInt8](repeating: 0, count: dim * dim * 4)

        // Deterministic xorshift64 so the grain is stable across launches/previews.
        var seed: UInt64 = 0x9E3779B97F4A7C15
        func nextByte() -> UInt8 {
            seed ^= seed << 13
            seed ^= seed >> 7
            seed ^= seed << 17
            return UInt8(truncatingIfNeeded: seed)
        }

        for i in 0..<(dim * dim) {
            let v = nextByte()
            pixels[i * 4 + 0] = v
            pixels[i * 4 + 1] = v
            pixels[i * 4 + 2] = v
            pixels[i * 4 + 3] = 255
        }

        let cg = pixels.withUnsafeMutableBytes { raw -> CGImage? in
            let ctx = CGContext(
                data: raw.baseAddress,
                width: dim, height: dim,
                bitsPerComponent: 8, bytesPerRow: bytesPerRow,
                space: CGColorSpaceCreateDeviceRGB(),
                bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue
            )
            return ctx?.makeImage()
        }

        if let cg {
            return Image(decorative: cg, scale: 1, orientation: .up)
        }
        return Image(systemName: "square")  // unreachable fallback
    }()
}

#Preview {
    PayviaHomeView()
}
