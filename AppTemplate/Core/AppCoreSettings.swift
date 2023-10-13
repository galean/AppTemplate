//
//  AppSettings.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 20.02.2023.
//

import Foundation
import SystemConfiguration
import CoreIntegrations

class AppSettings: CoreSettingsProtocol {
    // MARK: - Properties
    var appID: String = "" // Should be given in a task by PM or taken from AppStoreConnect
    var subscriptionsSecret = "" // Should be given in a task by PM or taken from AppStoreConnect
    var attributionServerSecret = "" // Should be given in a task by PM
    var amplitudeSecret: String = "" // Should be given in a task by PM
    var appsFlyerKey: String = "" // Should be given in a task by PM
    var revenuecatApiKey: String = "" // Should be given in a task by PM

//    var termsURL: URL = URL(string: "")! // Should be given in a task by PM
//    var privacyURL: URL = URL(string: "")! // Should be given in a task by PM
//    var supportMail: String = ""
//    var contactUsURL: URL = URL(string: "")!
//    var appStoreURL: URL = URL(string: "")!

    @UDStorage(key: "launchCountKey", defaultValue: 0)
    var launchCount: Int
    
//    @UDStorage(key: "cohortSent", defaultValue: false)
//    var isCohortSent: Bool
    
    @UDStorage(key: "subscriptionID", defaultValue: nil)
    var subscriptionID: String?
    
    var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
    
    var isConnectedToNetwork: Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        return (isReachable && !needsConnection)
    }
}
