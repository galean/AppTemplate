//
//  SubscriptionManager.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 20.02.2023.
//

import Foundation
//import TLMCoreManager

//final class SubscriptionManager {
//    static let shared = SubscriptionManager()
//    private init() { }
//    
//    func purchase(identifier: String, completion: @escaping (String?) -> Void) {
//        TLMCoreManager.shared.purchase(identifier, quantity: 1, atomically: true) { result in
//            switch result {
//            case .success(let details):
//                AppSettings.shared.subscriptionID = details.productId
//                completion(nil)
//            case .cancelled:
//                completion("User cancelled payment")
//            case .internetError:
//                completion("Could not connect to the network")
//            case .deferredPurchase:
//                completion("Deferred Purchase")
//            case .error(let skerror):
//                var errorDescription: String
//                switch skerror.code {
//                case .unknown: errorDescription = "Unknown error. Please contact support"
//                case .clientInvalid: errorDescription = "Not allowed to make the payment"
//                case .paymentInvalid: errorDescription = "The purchase identifier was invalid"
//                case .paymentNotAllowed: errorDescription = "The device is not allowed to make the payment"
//                case .storeProductNotAvailable: errorDescription = "The product is not available in the current storefront"
//                case .cloudServicePermissionDenied: errorDescription = "Access to cloud service information is not allowed"
//                case .cloudServiceNetworkConnectionFailed: errorDescription = "Could not connect to the network"
//                case .cloudServiceRevoked: errorDescription = "User has revoked permission to use this cloud service"
//                case .paymentCancelled: errorDescription = "User cancelled payment"
//                default: errorDescription = (skerror as NSError).localizedDescription
//                }
//
//                completion(errorDescription)
//            }
//        }
//    }
//
//    func verifyPremium(completion: @escaping (String?) -> Void) {
//        let subscriptions: Set<String> = Set(SubscriptionType.allCases.map { $0.rawValue })
//
//        TLMCoreManager.shared.verifyPremium(premiumSubscriptionIds: subscriptions, premiumPurchaseIds: []) { result in
//            switch result {
//            case .premium(let receiptItem):
//                AppSettings.shared.subscriptionID = receiptItem.productId
//                completion(nil)
//            case .notPremium:
//                AppSettings.shared.subscriptionID = ""
//                completion("Nothing to restore")
//            case .internetError:
//                completion("Could not connect to the network")
//            case .error(let receiptError):
//                let errorDescription = receiptError.localizedDescription
//                completion(errorDescription)
//                break
//            }
//        }
//    }
//}
