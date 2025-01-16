
import SwiftUI

struct MainNavigationView: View {
    @EnvironmentObject var coordinator: DefaultNavigationCoordinator
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationState.path) {
            //navigation entry point is splash screen
            SplashView()
                .navigationDestination(for: AppDestination.self) { destination in
                    destination.view
                }
        }
        .sheet(item: $coordinator.presentedSheet) { destination in
            destination.view
        }
        .fullScreenCover(item: $coordinator.presentedFullScreen) { destination in
            destination.view
        }
        .task {
            AppCoreManager.shared.configurationFinishCompletion = {
                DispatchQueue.main.async {
                    coordinator.push(.onboarding1)
                }
            }
        }
        .onOpenURL { url in
            //deep link open handle
            guard let host = url.host(), host == "specialoffer" else {
                return
            }
            coordinator.push(.paywall)
        }
    }
}



#Preview {
    MainNavigationView()
}
