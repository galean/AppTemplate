//
//  AppConfiguration.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 03.10.2023.
//

import Foundation
import CoreIntegrations

struct AppCoreConfiguration: CoreConfigurationProtocol {
    var attributionServerDataSource: any AttributionServerDataSource = CoreAttributionDataSource()
    
    var appSettings: CoreSettingsProtocol = AppSettings()
    var remoteConfigDataSource: any CoreRemoteDataSource = RemoteConfigDataSource()
    var amplitudeDataSource: any CoreAnalyticsDataSource = AnalyticsDataSource()
    var initialConfigurationDataSource: (any ConfigurationEventsDataSource)? = nil
    var useDefaultATTRequest = true
    var paywallDataSource: any CorePaywallDataSource = PaywallDataSource()
}

struct CoreAttributionDataSource: AttributionServerDataSource {
    enum AttributionEndpoints: String, AttributionServerEndpointsProtocol {
        case install_server_path = "install_server_path from FB"
        case purchase_server_path = "purchase_server_path from FB"
    }
}
