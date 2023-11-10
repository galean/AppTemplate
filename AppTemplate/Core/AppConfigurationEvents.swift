//
//  AppConfigurationEvents.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 12.10.2023.
//

import Foundation
import CoreIntegrations

struct AppConfigurationDataSource: ConfigurationEventsDataSource {
    typealias AppInitialConfigEvents = AppConfigurationEvents
}

enum AppConfigurationEvents: String, ConfigurationEvent {
    case someEvent = "someEvent"
    
    var isFirstStartOnly: Bool {
        return true
    }
    
    var isRequiredToContunue: Bool {
        return false
    }
    
    var key: String {
        return rawValue
    }
}
