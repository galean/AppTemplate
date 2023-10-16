//
//  AppAttributionServerEnpoints.swift
//  AppTemplate
//
//  Created by Anzhy on 16.10.2023.
//

import Foundation
import CoreIntegrations

struct AppAttributionDataSource: AttributionServerDataSource {
    typealias AttributionEndpoints = AppAttributionServerEnpoints
}

enum AppAttributionServerEnpoints: String, AttributionServerEndpointsProtocol {
    case install = "/install-application"
    case purchase = "/subscribe"
    
    static var serverURLPath: String {
        return "https://subscriptions.apitlm.com"
    }
}
