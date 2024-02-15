//
//  PaywallType.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 14/11/23.
//

import Foundation
import CoreIntegrations

public enum PurchasesKeys: String, CaseIterable {
    public var id: String { return rawValue }
    
    case annual_34_99 = "annual.34.99"
    case weekly_9_99 = "week.9.99"
    case lifetime_34_99 = "lifetime.99.99"
}

public enum PaywallConfig: String, CaseIterable, CorePaywallConfiguration {
    public typealias PurchaseIdentifier = PurchasesKeys
    
    //the same values as remote console has
    case ct_vap_1 = "3_box"
    case ct_vap_2 = "clear_trial_vap"
    case ct_vap_3 = "ct_vap_3"
    
    public var id: String { return rawValue }
    
    public var activeForPaywall: [PurchaseIdentifier] {
        switch self {
        case .ct_vap_1:
            return [.weekly_9_99, .annual_34_99]
        case .ct_vap_2:
            return [.lifetime_34_99]
        case .ct_vap_3:
            return [.weekly_9_99]
        }
    }
}

