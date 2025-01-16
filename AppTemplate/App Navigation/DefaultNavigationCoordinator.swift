
import SwiftUI

class DefaultNavigationCoordinator: ObservableObject, NavigationCoordinator {
    @Published var navigationState = NavigationState()
    @Published var presentedSheet: AppDestination?
    @Published var presentedFullScreen: AppDestination?
    @Published public var presentation:PreentationStyle = .push

    func push(_ destination: AppDestination) {
        presentation = .push
        navigationState.destinations.append(destination)
        navigationState.updatePath()
    }

    func pop() {
        navigationState.destinations.removeLast()
        navigationState.updatePath()
    }

    func popToRoot() {
        navigationState.destinations.removeLast(navigationState.destinations.count)
        navigationState.updatePath()
    }
    
    func popTo(_ destination: AppDestination) {
        if let index = navigationState.destinations.firstIndex(of: destination) {
            navigationState.destinations.removeSubrange(index+1..<navigationState.destinations.count)
            navigationState.updatePath()
        }else{
            assertionFailure("Cant popTo: \(destination), no such view in stack")
        }
    }

    func sheet(_ destination: AppDestination) {
        presentation = .sheet
        presentedSheet = destination
    }
    
    func fullScreen(_ destination: AppDestination) {
        presentation = .sheet
        presentedFullScreen = destination
    }

    func dismiss() {
        presentedSheet = nil
        presentedFullScreen = nil
    }
}


