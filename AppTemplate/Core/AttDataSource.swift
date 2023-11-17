//
//  AttDataSource.swift
//  AppTemplate
//
//  Created by Anzhy on 16.10.2023.
//

import Foundation
import CoreIntegrations

struct AttDataSource:AttributionServerDataSource {
    enum AttributionEndpoints: String, AttributionServerEndpointsProtocol {
        case install = "/install-application"
        case purchase = "/subscribe"
        static var serverURLPath: String {
            #warning("Dont forget to change it!")
            return "https://endpoint.com"
        }
    }
}
