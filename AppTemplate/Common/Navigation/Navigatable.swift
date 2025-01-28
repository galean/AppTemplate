
import SwiftUI

protocol Navigatable: ObservableObject {
    func push(_ destination: AppDestination)
    func pop()
    func popToRoot()
    func sheet(_ destination: AppDestination)
    func fullScreen(_ destination: AppDestination)
    func dismiss()
}

enum PreentationStyle {
    case push
    case sheet
}

private struct CoordinatorKey: EnvironmentKey {
    static let defaultValue: (any Navigatable)? = nil
}

extension EnvironmentValues {
    var coordinator: (any Navigatable)? {
        get { self[CoordinatorKey.self] }
        set { self[CoordinatorKey.self] = newValue }
    }
}
