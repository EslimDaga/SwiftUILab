import SwiftUI

@main
struct SwiftUILabApp: App {
    init() {
        AppFont.register()
    }

    var body: some Scene {
        WindowGroup {
            GalleryView()
        }
    }
}
