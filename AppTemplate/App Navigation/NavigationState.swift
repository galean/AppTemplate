
import SwiftUI

struct NavigationState {
    var path = NavigationPath()
    var destinations: [AppDestination] = []
    
    mutating func updatePath() {
        path = NavigationPath(destinations)
    }
}
