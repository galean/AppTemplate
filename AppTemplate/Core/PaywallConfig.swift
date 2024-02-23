//
//  PaywallType.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 14/11/23.
//

import Foundation
import CoreIntegrations

enum AppPurchaseGroup: String, CorePurchaseGroup {
    case Pro
}

enum AppPurchaseIdentifier: String, CorePurchaseIdentifier {
    var purchaseGroup: any CorePurchaseGroup {
        return AppPurchaseGroup.Pro
    }
    
//    var purchaseGroup: any CoreIntegrations.CorePurchaseGroup {
//        //by default return main subscription group - Pro
//        return .Pro
//        
//        //return different group for each subscription if you have several groups in the app
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
    var id: String { return rawValue }
    
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

