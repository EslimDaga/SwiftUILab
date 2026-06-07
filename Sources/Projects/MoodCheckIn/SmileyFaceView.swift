import SwiftUI

struct SmileyFaceView: View {
    let mood: Mood

    var body: some View {
        GeometryReader { proxy in
            let geometry = FaceGeometry(in: proxy.size)
            ZStack {
                Circle()
                    .fill(mood.faceColor)
                    .frame(width: geometry.radius * 2, height: geometry.radius * 2)
                    .position(geometry.center)

                FaceFeatures(mood: mood)
                    .id(mood)
                    .transition(.opacity.combined(with: .scale(scale: 0.97)))
            }
        }
        .accessibilityHidden(true)
    }
}

private struct FaceFeatures: View {
    let mood: Mood

    var body: some View {
        Canvas { context, size in
            let geometry = FaceGeometry(in: size)
            switch mood.faceStyle {
            case .classic: drawClassicFace(in: context, geometry: geometry)
            case .serene: drawSereneFace(in: context, geometry: geometry)
            }
        }
    }

    private func drawClassicFace(in context: GraphicsContext, geometry g: FaceGeometry) {
        drawHairLoop(in: context, geometry: g)
        drawDotEyes(in: context, geometry: g)
        if mood.showsBrows {
            drawBrows(in: context, geometry: g)
        }
        drawClassicNose(in: context, geometry: g)
        if mood == .happy {
            drawHappyMouth(in: context, geometry: g)
        } else {
            drawStyledMouth(in: context, geometry: g)
        }
    }

    private func drawDotEyes(in context: GraphicsContext, geometry g: FaceGeometry) {
        let eyeRadius = g.radius * 0.0786
        for eyeCenter in [g.point(-0.4286, -0.2857), g.point(0.4286, -0.2857)] {
            let rect = CGRect(
                x: eyeCenter.x - eyeRadius,
                y: eyeCenter.y - eyeRadius,
                width: eyeRadius * 2,
                height: eyeRadius * 2
            )
            context.fill(Path(ellipseIn: rect), with: .color(MoodPalette.ink))
        }
    }

    private func drawBrows(in context: GraphicsContext, geometry g: FaceGeometry) {
        var brows = Path()
        brows.move(to: g.point(-0.55, -0.45))
        brows.addLine(to: g.point(-0.30, -0.36))
        brows.move(to: g.point(0.55, -0.45))
        brows.addLine(to: g.point(0.30, -0.36))
        context.stroke(brows, with: .color(MoodPalette.ink), style: g.stroke)
    }

    private func drawClassicNose(in context: GraphicsContext, geometry g: FaceGeometry) {
        var nose = Path()
        nose.move(to: g.point(-0.036, -0.464))
        nose.addQuadCurve(to: g.point(0.107, -0.036), control: g.point(0.036, -0.214))
        nose.addLine(to: g.point(-0.179, -0.036))
        context.stroke(nose, with: .color(MoodPalette.ink), style: g.stroke)
    }

    private func drawStyledMouth(in context: GraphicsContext, geometry g: FaceGeometry) {
        let drop = mood.mouthDrop
        var mouth = Path()
        mouth.move(to: g.point(-0.332, 0.367 + drop))
        mouth.addQuadCurve(
            to: g.point(0.332, 0.367 + drop),
            control: g.point(0.0, 0.367 + drop + mood.mouthCurvature)
        )
        mouth.move(to: g.point(-0.386, 0.253 + drop))
        mouth.addQuadCurve(to: g.point(-0.352, 0.480 + drop), control: g.point(-0.295, 0.367 + drop))
        mouth.move(to: g.point(0.386, 0.253 + drop))
        mouth.addQuadCurve(to: g.point(0.352, 0.480 + drop), control: g.point(0.295, 0.367 + drop))
        context.stroke(mouth, with: .color(MoodPalette.ink), style: g.stroke)
    }

    private func drawHappyMouth(in context: GraphicsContext, geometry g: FaceGeometry) {
        var mouth = Path()
        mouth.move(to: g.point(-0.5, 0.179))
        mouth.addQuadCurve(to: g.point(0.5, 0.179), control: g.point(0.0, 0.607))
        mouth.move(to: g.point(-0.557, 0.107))
        mouth.addQuadCurve(to: g.point(-0.557, 0.25), control: g.point(-0.443, 0.179))
        mouth.move(to: g.point(0.557, 0.107))
        mouth.addQuadCurve(to: g.point(0.557, 0.25), control: g.point(0.443, 0.179))
        context.stroke(mouth, with: .color(MoodPalette.ink), style: g.stroke)
    }

    private func drawHairLoop(in context: GraphicsContext, geometry g: FaceGeometry) {
        var hair = Path()
        hair.move(to: g.point(-0.4286, -0.8214))
        hair.addCurve(
            to: g.point(0.1071, -1.3571),
            control1: g.point(0.0, -0.8929),
            control2: g.point(0.1429, -1.1429)
        )
        hair.addCurve(
            to: g.point(-0.1429, -1.2857),
            control1: g.point(0.0714, -1.5714),
            control2: g.point(-0.1429, -1.5714)
        )
        hair.addCurve(
            to: g.point(0.1429, -0.9643),
            control1: g.point(-0.1429, -1.0714),
            control2: g.point(0.0, -0.9643)
        )
        hair.addCurve(
            to: g.point(0.6429, -1.1786),
            control1: g.point(0.3571, -0.9643),
            control2: g.point(0.5, -1.0714)
        )
        context.stroke(hair, with: .color(MoodPalette.ink), style: g.stroke)
    }

    private func drawSereneFace(in context: GraphicsContext, geometry g: FaceGeometry) {
        drawBrowSwoosh(in: context, geometry: g)
        drawForeheadLine(in: context, geometry: g)
        drawClosedEyes(in: context, geometry: g)
        drawSereneNose(in: context, geometry: g)
        drawSereneMouth(in: context, geometry: g)
    }

    private func drawBrowSwoosh(in context: GraphicsContext, geometry g: FaceGeometry) {
        var swoosh = Path()
        swoosh.move(to: g.point(-0.708, -1.00))
        swoosh.addCurve(
            to: g.point(0.75, -1.00),
            control1: g.point(-0.542, -0.542),
            control2: g.point(0.083, -0.625)
        )
        context.stroke(swoosh, with: .color(MoodPalette.ink), style: g.stroke)
    }

    private func drawForeheadLine(in context: GraphicsContext, geometry g: FaceGeometry) {
        var line = Path()
        line.move(to: g.point(-0.583, -0.417))
        line.addQuadCurve(to: g.point(0.5, -0.417), control: g.point(0.0, -0.458))
        context.stroke(line, with: .color(MoodPalette.ink), style: g.stroke)
    }

    private func drawClosedEyes(in context: GraphicsContext, geometry g: FaceGeometry) {
        var eyes = Path()
        eyes.move(to: g.point(-0.5, -0.208))
        eyes.addQuadCurve(to: g.point(-0.292, -0.208), control: g.point(-0.375, -0.142))
        eyes.move(to: g.point(0.125, -0.208))
        eyes.addQuadCurve(to: g.point(0.333, -0.208), control: g.point(0.25, -0.142))
        context.stroke(eyes, with: .color(MoodPalette.ink), style: g.stroke)
    }

    private func drawSereneNose(in context: GraphicsContext, geometry g: FaceGeometry) {
        var nose = Path()
        nose.move(to: g.point(-0.125, -0.208))
        nose.addLine(to: g.point(-0.292, 0.208))
        nose.addQuadCurve(to: g.point(-0.125, 0.35), control: g.point(-0.317, 0.35))
        context.stroke(nose, with: .color(MoodPalette.ink), style: g.stroke)
    }

    private func drawSereneMouth(in context: GraphicsContext, geometry g: FaceGeometry) {
        var mouth = Path()
        mouth.move(to: g.point(-0.25, 0.583))
        mouth.addQuadCurve(to: g.point(0.208, 0.458), control: g.point(-0.042, 0.567))
        context.stroke(mouth, with: .color(MoodPalette.ink), style: g.stroke)
    }
}

private struct FaceGeometry {
    let center: CGPoint
    let radius: CGFloat
    let stroke: StrokeStyle

    init(in size: CGSize) {
        radius = min(size.width * 0.42, size.height * 0.30)
        center = CGPoint(x: size.width / 2, y: size.height * 0.60)
        stroke = StrokeStyle(lineWidth: radius * 0.04, lineCap: .round, lineJoin: .round)
    }

    func point(_ dx: CGFloat, _ dy: CGFloat) -> CGPoint {
        CGPoint(x: center.x + dx * radius, y: center.y + dy * radius)
    }
}

#Preview("Expressions") {
    HStack(spacing: 0) {
        ForEach(Mood.allCases) { mood in
            SmileyFaceView(mood: mood)
                .frame(width: 110, height: 150)
                .background(mood.cardBackground)
        }
    }
}
