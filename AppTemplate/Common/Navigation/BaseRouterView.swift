import SwiftUI

struct BaseRouterView<RootView>: View where RootView: View {
    @EnvironmentObject var coordinator: BaseCoordinator
    
    private var rootView: RootView
        
    init(@ViewBuilder content: @escaping () -> RootView) {
        self.rootView = content()
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.navigationState.path) {
            rootView
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
    }
}
