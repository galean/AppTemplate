//
//  AppAnalytics.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 03.10.2023.
//

import Foundation
import CoreIntegrations

struct AnalyticsDataSource: CoreAnalyticsDataSource {
    typealias AnalyticsEvents = AppAnalyticsEvents
    typealias AnalyticsUserProperties = AppAnalyticsUserProperties
}

enum AppAnalyticsEvents: String, CoreAnalyzableEvent {
    case contact_permission
    case notification_permission
    case location_permission
    case gallery_permission
    case camera_permission
    case microphone_permission
    case local_network_permission

    case subscription_shown
    case subscription_subscribe_clicked
    case subscription_purchased
    case subscription_closed
    case subscription_restore_clicked
    case subscription_error

    case push_notification_opened
    case custom_rate_us_shown

    case some_event

    var key: String { return rawValue }
}

enum AppAnalyticsUserProperties: String, CoreAnalyzableUserProperty {
    case screenshot_taken
    case camera_access
    
    var key: String { return rawValue }
}
