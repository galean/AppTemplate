import SwiftUI

@main
struct AppTemplateApp: App {
    @StateObject private var coordinator = BaseCoordinator()
    
    let screenshotNoti = NotificationCenter.default.publisher(for: UIApplication.userDidTakeScreenshotNotification)
    
    var body: some Scene {
        WindowGroup {
            AppRouter()
                .environmentObject(coordinator)
        }
    }
}
