import SwiftUI

extension Animation {
    static let mood: Animation = .spring(response: 0.45, dampingFraction: 0.82)
}

struct MoodCheckInView: View {
    private let totalSteps = 3

    @State private var selectedMood: Mood = .happy
    @State private var selectedWorries: Set<Worry> = []
    @State private var currentStep = 1

    var onSkip: () -> Void = {}
    var onFinish: () -> Void = {}

    var body: some View {
        ZStack {
            MoodPalette.surface.ignoresSafeArea()

            Group {
                switch currentStep {
                case 1: moodStep
                case 2: worriesStep
                default: doneStep
                }
            }
            .id(currentStep)
            .transition(.opacity)
        }
        .toolbarVisibility(.hidden, for: .navigationBar)
    }

    private var moodStep: some View {
        VStack(spacing: 0) {
            faceCard
            moodPanel
        }
    }

    private var faceCard: some View {
        VStack(spacing: 0) {
            StepProgressBar(totalSteps: totalSteps, currentStep: currentStep)
                .padding(.horizontal, 24)
                .padding(.top, 12)

            SmileyFaceView(mood: selectedMood)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .padding(.horizontal, 24)
        }
        .frame(maxWidth: .infinity)
        .background {
            UnevenRoundedRectangle(bottomLeadingRadius: 36, bottomTrailingRadius: 36)
                .fill(selectedMood.cardBackground)
                .ignoresSafeArea(edges: .top)
        }
    }

    private var moodPanel: some View {
        VStack(spacing: 28) {
            MoodCarousel(moods: Mood.allCases, selection: $selectedMood)
                .padding(.top, 28)

            Text("How do you\nfeel today?")
                .font(.poppins(40, weight: .bold, relativeTo: .largeTitle))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)

            Spacer(minLength: 0)

            actionBar
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
    }

    private var worriesStep: some View {
        VStack(spacing: 0) {
            StepProgressBar(totalSteps: totalSteps, currentStep: currentStep, tint: .white)
                .padding(.horizontal, 24)
                .padding(.top, 12)

            Text("What's\nworrying you?")
                .font(.poppins(36, weight: .bold, relativeTo: .largeTitle))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)
                .padding(.top, 40)

            Spacer(minLength: 24)

            worryGrid
                .padding(.horizontal, 20)

            Spacer(minLength: 24)

            actionBar
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
    }

    private var worryGrid: some View {
        let columns = [
            GridItem(.flexible(), spacing: 12),
            GridItem(.flexible(), spacing: 12),
        ]
        return LazyVGrid(columns: columns, spacing: 12) {
            ForEach(Worry.allCases) { worry in
                Button {
                    toggle(worry)
                } label: {
                    WorryChip(worry: worry, isSelected: selectedWorries.contains(worry))
                }
                .buttonStyle(.plain)
            }
        }
    }

    private var doneStep: some View {
        VStack(spacing: 28) {
            StepProgressBar(totalSteps: totalSteps, currentStep: currentStep, tint: .white)
                .padding(.horizontal, 24)
                .padding(.top, 12)

            Spacer(minLength: 0)

            SmileyFaceView(mood: selectedMood)
                .frame(width: 200, height: 220)

            Text("Thanks for\nsharing")
                .font(.poppins(36, weight: .bold, relativeTo: .largeTitle))
                .multilineTextAlignment(.center)
                .foregroundStyle(.white)

            Spacer(minLength: 0)

            actionBar
                .padding(.horizontal, 24)
                .padding(.bottom, 8)
        }
        .frame(maxWidth: .infinity)
    }

    private var actionBar: some View {
        HStack(spacing: 16) {
            Button("Skip", action: onSkip)
                .font(.poppins(18, weight: .medium, relativeTo: .title3))
                .foregroundStyle(.white)
                .padding(.horizontal, 12)

            Button(action: advance) {
                HStack(spacing: 8) {
                    Text("Next")
                    Image(systemName: "chevron.right")
                        .font(.body.weight(.semibold))
                }
                .font(.poppins(18, weight: .semibold, relativeTo: .title3))
                .foregroundStyle(.black)
                .frame(maxWidth: .infinity)
                .frame(height: 64)
                .background(.white, in: .capsule)
            }
        }
    }

    private func advance() {
        guard currentStep < totalSteps else {
            onFinish()
            return
        }
        withAnimation(.snappy) {
            currentStep += 1
        }
    }

    private func toggle(_ worry: Worry) {
        withAnimation(.snappy) {
            if selectedWorries.contains(worry) {
                selectedWorries.remove(worry)
            } else {
                selectedWorries.insert(worry)
            }
        }
    }
}

private struct StepProgressBar: View {
    let totalSteps: Int
    let currentStep: Int
    var tint: Color = MoodPalette.ink

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<totalSteps, id: \.self) { index in
                Capsule()
                    .fill(index < currentStep ? tint : tint.opacity(0.15))
                    .frame(height: 3)
            }
        }
        .accessibilityElement()
        .accessibilityLabel("Onboarding progress")
        .accessibilityValue("Step \(currentStep) of \(totalSteps)")
    }
}

private struct WorryChip: View {
    let worry: Worry
    let isSelected: Bool

    var body: some View {
        Text(worry.title)
            .font(.poppins(17, weight: .medium, relativeTo: .body))
            .foregroundStyle(isSelected ? .black : .white)
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background { background }
            .accessibilityAddTraits(isSelected ? .isSelected : [])
    }

    @ViewBuilder
    private var background: some View {
        if isSelected {
            Capsule().fill(MoodPalette.worryAccent)
        } else if worry == .other {
            Capsule().stroke(Color.white.opacity(0.4), lineWidth: 1.5)
        } else {
            Capsule().fill(MoodPalette.chipBackground)
        }
    }
}

private struct MoodCarousel: View {
    let moods: [Mood]
    @Binding var selection: Mood

    @State private var scrolledMood: Mood?

    var body: some View {
        GeometryReader { proxy in
            let chipWidth = proxy.size.width * 0.56
            let sidePadding = (proxy.size.width - chipWidth) / 2

            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(moods) { mood in
                        Button {
                            withAnimation(.mood) { selection = mood }
                        } label: {
                            MoodChip(mood: mood, isSelected: mood == selection)
                        }
                        .buttonStyle(.plain)
                        .frame(width: chipWidth)
                    }
                }
                .scrollTargetLayout()
            }
            .contentMargins(.horizontal, sidePadding, for: .scrollContent)
            .scrollTargetBehavior(.viewAligned)
            .scrollPosition(id: $scrolledMood, anchor: .center)
            .scrollIndicators(.hidden)
            .onAppear { scrolledMood = selection }
            .onChange(of: selection) {
                guard scrolledMood != selection else { return }
                withAnimation(.mood) { scrolledMood = selection }
            }
            .onChange(of: scrolledMood) {
                guard let scrolledMood, scrolledMood != selection else { return }
                withAnimation(.mood) { selection = scrolledMood }
            }
        }
        .frame(height: 64)
    }
}

private struct MoodChip: View {
    let mood: Mood
    let isSelected: Bool

    var body: some View {
        Text(mood.title)
            .font(.poppins(20, weight: .semibold, relativeTo: .title3))
            .foregroundStyle(isSelected ? .black : .white)
            .frame(maxWidth: .infinity)
            .frame(height: 56)
            .background(
                isSelected ? mood.accentColor : MoodPalette.chipBackground,
                in: .capsule
            )
            .accessibilityAddTraits(isSelected ? .isSelected : [])
    }
}

#Preview {
    MoodCheckInView()
}
