//
//  PaywallType.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 14/11/23.
//

import Foundation
import CoreIntegrations

public enum PaywallConfig: String, CaseIterable, CorePaywallConfiguration {
    //the same values as remote console has
    case ct_vap_1 = "3_box"
    case ct_vap_2 = "clear_trial_vap"
    case ct_vap_3 = "ct_vap_3"
    
    public var id: String { return rawValue }
}
