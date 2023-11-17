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

enum RemoteABTests: String, CoreRemoteABTestable {

    var activeForSources: [CoreUserSource] {
        switch self {
        case .ab_paywall_general:
            return [.organic, .asa]
        case .ab_paywall_fb_google:
            return [.fbgoogle]
        case .ab_paywall_ct_vap_3,
                .special_offer_shown:
            return CoreUserSource.allCases.except(.ipat)
        }
    }
    
    case ab_paywall_general
    case ab_paywall_fb_google
    case ab_paywall_ct_vap_3
    case special_offer_shown
    
    var key: String { return rawValue }
  
    var defaultValue: String {
        switch self {
        case .ab_paywall_general:
            return "none"
        case .ab_paywall_fb_google:
            return "none"
        case .ab_paywall_ct_vap_3:
            return "none"
        case .special_offer_shown:
            return "none"
        }
    }
    
    var boolValue: Bool {
        get {
            switch self {
            default:
                let stringValue = value
                switch stringValue {
                case "true", "1", "B":
                    return true
                case "false", "0", "none", "A", "C", "":
                    return false
                default:
                    assertionFailure()
                    return false
                }
            }
        }
    }
}


enum RemoteConfigs: String, CaseIterable, CoreRemoteConfigurable {
    var activeForSources: [CoreUserSource] {
        switch self {
        case .subscription_screen_style_full, .subscription_screen_style_h,
                .rate_us_primary_shown, .rate_us_secondary_shown, .isRateUsAvailable:
            return CoreUserSource.allCases.except(.ipat)
        }
    }
    
    case subscription_screen_style_full
    case subscription_screen_style_h
    case rate_us_primary_shown
    case rate_us_secondary_shown
    case isRateUsAvailable
    
    var key: String { return rawValue }
    var defaultValue: String { return "false" }
    
    var boolValue: Bool {
        get {
            switch self {
            default:
                let stringValue = value
                switch stringValue {
                case "true", "1", "B":
                    return true
                case "false", "0", "none", "A", "C", "":
                    return false
                default:
                    assertionFailure()
                    return false
                }
            }
        }
    }
    
}

