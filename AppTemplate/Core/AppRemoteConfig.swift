//
//  AppRemoteConfig.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 03.10.2023.
//

import Foundation
import CoreIntegrations

struct RemoteConfigDataSource: CoreRemoteDataSource {
    typealias CoreRemoteConfigs = RemoteConfigs
    typealias CoreRemoteABTests = RemoteABTests
}

enum RemoteConfigs: String, CoreRemoteConfigurable {
    case subscription_screen_style_full
    case subscription_screen_style_h
    case rate_us_primary_shown
    case rate_us_secondary_shown

    var key: String { return rawValue }
    
    var defaultValue: String {
        return "false"
    }
    
    var boolValue: Bool {
        return false
    }
    
}

enum RemoteABTests: String, CoreRemoteABTestable {
    case ab_paywall_general
    case ab_paywall_fb_google
    
    var key: String { return rawValue }
    
    var defaultValue: String { return "none" }
    
    var boolValue: Bool { return false }
    
}
