//
//  PaywallType.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 14/11/23.
//

import Foundation
import CoreIntegrations

public enum PaywallConfig: String, CaseIterable, PaywallConfiguration {
    //the same values as remote console has
    case ct_vap_1 = "ct_vap_1"
    case ct_vap_2 = "ct_vap_2"
    case ct_vap_3 = "ct_vap_3"
    
    public var id: String { return rawValue }
}
