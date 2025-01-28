import Foundation
import Purchases

protocol PaywallViewProtocol {
    var source: PaywallSource { get }
    var paywallConfig: PaywallType { get }
}

enum PaywallSource: Hashable {
    case onboarding
    case main
    case settings
}



