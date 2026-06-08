import SwiftUI

struct PayviaRShape: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        let s = min(rect.width, rect.height) / 200
        func pt(_ x: CGFloat, _ y: CGFloat) -> CGPoint { CGPoint(x: x * s, y: y * s) }

        p.move(to: pt(94.6, 92))
        p.addCurve(to: pt(106.5, 88.8), control1: pt(100.1, 92), control2: pt(104.1, 90.9))
        p.addCurve(to: pt(110.2, 78.6), control1: pt(108.9, 86.8), control2: pt(110.2, 83.4))
        p.addCurve(to: pt(106.5, 68.5), control1: pt(110.2, 73.9), control2: pt(108.9, 70.6))
        p.addCurve(to: pt(94.6, 65.5), control1: pt(104.1, 66.5), control2: pt(100.1, 65.5))
        p.addLine(to: pt(83.4, 65.5))
        p.addLine(to: pt(83.4, 92))
        p.addLine(to: pt(94.6, 92))
        p.closeSubpath()

        p.move(to: pt(83.4, 110.3))
        p.addLine(to: pt(83.4, 149.3))
        p.addLine(to: pt(56.8, 149.3))
        p.addLine(to: pt(56.8, 46.2))
        p.addLine(to: pt(97.4, 46.2))
        p.addCurve(to: pt(127.2, 53.1), control1: pt(111, 46.2), control2: pt(120.9, 48.5))
        p.addCurve(to: pt(136.7, 74.7), control1: pt(133.6, 57.6), control2: pt(136.7, 64.8))
        p.addCurve(to: pt(131.8, 91.5), control1: pt(136.7, 81.5), control2: pt(135.1, 87.1))
        p.addCurve(to: pt(116.9, 101.1), control1: pt(128.5, 95.8), control2: pt(123.6, 99.1))
        p.addCurve(to: pt(126.7, 106.8), control1: pt(120.6, 102), control2: pt(123.8, 103.9))
        p.addCurve(to: pt(135.4, 120.1), control1: pt(129.6, 109.7), control2: pt(132.5, 114.1))
        p.addLine(to: pt(149.9, 149.3))
        p.addLine(to: pt(121.6, 149.3))
        p.addLine(to: pt(109, 123.7))
        p.addCurve(to: pt(101.3, 113.2), control1: pt(106.5, 118.6), control2: pt(103.9, 115))
        p.addCurve(to: pt(90.9, 110.3), control1: pt(98.7, 111.3), control2: pt(95.2, 110.3))
        p.addLine(to: pt(83.4, 110.3))
        p.closeSubpath()

        return p
    }
}

struct PayviaRMark: View {
    var size: CGFloat
    var color: Color = .white
    var ringTrim: CGFloat = 1
    var rProgress: Double = 1

    var body: some View {
        let inset = 11.5 / 200 * size
        let lineWidth = 20.0 / 200 * size

        ZStack {
            Circle()
                .trim(from: 0, to: ringTrim)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .padding(inset)
                .animation(.easeInOut(duration: 0.7), value: ringTrim)

            PayviaRShape()
                .fill(color, style: FillStyle(eoFill: true))
                .opacity(rProgress)
                .scaleEffect(0.55 + 0.45 * rProgress, anchor: .center)
                .animation(.spring(response: 0.45, dampingFraction: 0.7).delay(0.28), value: rProgress)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    PayviaRMark(size: 120)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(PayviaTheme.brand)
}
