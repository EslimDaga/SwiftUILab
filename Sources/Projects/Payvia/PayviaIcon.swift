import SwiftUI

enum Iconoir: String {
    case search
    case bell
    case eye
    case eyeClosed = "eye-closed"
    case copy
    case plus
    case transfer = "data-transfer-both"
    case grid = "view-grid"
    case edit = "edit-pencil"
    case chevronRight = "nav-arrow-right"
    case home = "home-simple"
    case stats = "graph-up"
    case wallet
    case settings
    case scan = "scan-qr-code"
    case user

    var assetName: String { "ico-\(rawValue)" }
}

extension Image {
    init(_ icon: Iconoir) {
        self.init(icon.assetName)
    }
}

struct IconoirView: View {
    let icon: Iconoir
    var size: CGFloat = 24

    var body: some View {
        Image(icon)
            .renderingMode(.template)
            .resizable()
            .scaledToFit()
            .frame(width: size, height: size)
    }
}

struct DiceBearAvatar: View {
    let seed: String
    var size: CGFloat = 52
    var cornerRadius: CGFloat? = nil

    private var url: URL? {
        let encoded = seed.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? seed
        return URL(string: "https://api.dicebear.com/10.x/adventurer-neutral/png?seed=\(encoded)&size=\(Int(size * 3))")
    }

    private var clip: AnyShape {
        if let cornerRadius {
            AnyShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
        } else {
            AnyShape(Circle())
        }
    }

    var body: some View {
        AsyncImage(url: url, transaction: Transaction(animation: .easeOut(duration: 0.25))) { phase in
            switch phase {
            case .success(let image):
                image.resizable().scaledToFill().transition(.opacity)
            case .failure:
                IconoirView(icon: .user, size: size * 0.5)
                    .foregroundStyle(Color(white: 0.55))
            case .empty:
                ProgressView().controlSize(.small).tint(Color(white: 0.55))
            @unknown default:
                Color(white: 0.90)
            }
        }
        .frame(width: size, height: size)
        .background(Color(red: 0.90, green: 0.91, blue: 0.93))
        .clipShape(clip)
    }
}
