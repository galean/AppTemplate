//
//  PaywallFactory.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import Foundation
import CoreIntegrations

typealias PaywallResultClosure = ((PaywallCloseResult) -> Void)

public protocol PaywallViewProtocol {
    var paywallConfig: PaywallConfig { get }
}

enum PaywallCloseResult {
    case close
    case purchase
    case showSpecialOffer
}

class PaywallFactory: NSObject {
    static func create(routerModal: RouterModalProtocol, container: DIContainer, type: PaywallConfig, screenSource: String, onDismiss: EmptyBlock? = nil) -> PaywallCoordinator {
        switch type {
        case .ct_vap_1:
            return EmptyPaywallCoordinator(routerModal: routerModal, container: container, screenSource: screenSource)
        case .ct_vap_2:
            return EmptyPaywallCoordinator(routerModal: routerModal, container: container, screenSource: screenSource)
        case .ct_vap_3:
            return EmptyPaywallCoordinator(routerModal: routerModal, container: container, screenSource: screenSource)
        }
    }
}
