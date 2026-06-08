import SwiftUI

struct PayviaWordmark: View {
    var size: CGFloat = 56
    var color: Color = .white
    var markTrim: CGFloat = 1
    var markProgress: Double = 1

    var body: some View {
        HStack(alignment: .top, spacing: size * 0.05) {
            Text("Payvia")
                .font(.bricolage(size, weight: .medium, relativeTo: .largeTitle))
                .foregroundStyle(color)

            PayviaRMark(
                size: size * 0.56,
                color: color,
                ringTrim: markTrim,
                rProgress: markProgress
            )
            .offset(y: size * 0.05)
        }
        .accessibilityElement(children: .ignore)
        .accessibilityLabel("Payvia")
        .accessibilityAddTraits(.isHeader)
    }
}

#Preview {
    PayviaWordmark(size: 80)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .payviaBackground()
}
