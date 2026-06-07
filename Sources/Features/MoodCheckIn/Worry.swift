import SwiftUI

enum Worry: String, CaseIterable, Identifiable {
    case sleepiness = "Sleepiness"
    case sadness = "Sadness"
    case anxiety = "Anxiety"
    case stress = "Stress"
    case loneliness = "Loneliness"
    case insomnia = "Insomnia"
    case anger = "Anger"
    case apathy = "Apathy"
    case envy = "Envy"
    case other = "Other"

    var id: Self { self }

    var title: String { rawValue }
}
