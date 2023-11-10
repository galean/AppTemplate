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
}
