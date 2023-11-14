//
//  AppConfiguration.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 03.10.2023.
//

import Foundation
import CoreIntegrations

struct AppCoreConfiguration: CoreConfigurationProtocol {
    var attributionServerDataSource: any AttributionServerDataSource = AttDataSource()
    var appSettings: CoreSettingsProtocol = AppSettings()
    var remoteConfigDataSource: any CoreRemoteDataSource = RemoteConfigDataSource()
    var amplitudeDataSource: any CoreAnalyticsDataSource = AnalyticsDataSource()
    var initialConfigurationDataSource: (any ConfigurationEventsDataSource)? = nil
    var useDefaultATTRequest = true
    var paywallDataSource: any CorePaywallDataSource = PaywallDataSource()
}


public protocol PaywallConfiguration: CaseIterable {
    var id: String { get }
}

public extension PaywallConfiguration {
    static func ==(lhs: any PaywallConfiguration, rhs: any PaywallConfiguration) -> Bool {
        return lhs.id == rhs.id
    }
}

public protocol CorePaywallDataSource {
    associatedtype PaywallInitialConfiguration: PaywallConfiguration
    
    var all: [PaywallInitialConfiguration] { get }
}

public extension CorePaywallDataSource {
    var all: [PaywallInitialConfiguration] {
        return PaywallInitialConfiguration.allCases as! [Self.PaywallInitialConfiguration]
    }
}

struct PaywallDataSource: CorePaywallDataSource {
    typealias PaywallInitialConfiguration = PaywallType
}

