//
//  PaywallType.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 14/11/23.
//

import Foundation
import CoreIntegrations

public enum ProPurchaseGroup: String, CorePurchaseGroup {
  case Pro
}

public enum AppPurchaseIdentifier: String, CorePurchaseIdentifier {
    public var purchaseGroup: any CorePurchaseGroup {
        //by default return main subscription group - Pro
        return ProPurchaseGroup.Pro
        
        //return different group for each subscription
        /*
        switch self {
        case .annual_34_99:
            return ProPurchaseGroup.Pro
        case .weekly_9_99:
            return ProPurchaseGroup.TestPro
        case .lifetime_34_99:
            return ProPurchaseGroup.PremiumPro
        }
         */
    }
    
//    var purchaseGroup: any CoreIntegrations.CorePurchaseGroup {
//        //by default return main subscription group - Pro
//        return .Pro
//        
//        //return different group for each subscription
//        /*
//        switch self {
//        case .annual_34_99:
//            return .Pro
//        case .weekly_9_99:
//            return .TestPro
//        case .lifetime_34_99:
//            return .PremiumPro
//        }
//         */
//    }
    public var id: String { return rawValue }
    
    case annual_34_99 = "annual.34.99"
    case weekly_9_99 = "week.9.99"
    case lifetime_34_99 = "lifetime.99.99"
}

enum PaywallConfig: String, CaseIterable, CorePaywallConfiguration {
    typealias CorePurchaseIdentifier = AppPurchaseIdentifier
    
    //the same values as remote console has
    case ct_vap_1 = "3_box"
    case ct_vap_2 = "clear_trial_vap"
    case ct_vap_3 = "ct_vap_3"
    
    var id: String { return rawValue }
    
    var purchases: [CorePurchaseIdentifier] {
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

