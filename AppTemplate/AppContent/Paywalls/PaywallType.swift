//
//  PaywallType.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 14/11/23.
//

import Foundation
import CoreIntegrations

#warning("Should be renamed..")
public enum PaywallType: String, CaseIterable, PaywallConfiguration {
    //the same values as remote console has
    case ct_vap_1 = "ct_vap_1"
    case ct_vap_2 = "ct_vap_2"
    case ct_vap_3 = "ct_vap_3"
    
    public var id: String { return rawValue }
}


//
extension PaywallType {
    
    var subscriptions: [Purchase] {
        /*
         func CoreManager.shared.storedOfferings() =>
         
         public func storedOfferings() -> Offerings? {
             guard let revenueCatManager else {
                 assertionFailure()
                 return nil
             }
             return revenueCatManager.storedOfferings <= stored offerings in revenueCatManager
         }
         */
//        guard let offerings = CoreManager.shared.storedOfferings(), let offering = offerings?[self.id] else {return []}
//            var subscriptions:[Subscription]?
//            offering.availablePackages.forEach { package in
//                let subscription = Subscription(package: package)
//                subscriptions?.append(subscription)
//            }
//            return subscriptions ?? []
        return []
    }
    
    func subscriptions(completion: @escaping ([Purchase]?) -> Void) {
        CoreManager.shared.offerings { offerings in
            guard let offering = offerings?[self.id] else {completion(nil); return}
            var subscriptions:[Purchase]?
            offering.availablePackages.forEach { package in
                let subscription = Purchase(package: package)
                subscriptions?.append(subscription)
            }
            completion(subscriptions)
        }
    }
    
    func purchase(subscription: Purchase, completion: @escaping (String?) -> Void) {
        CoreManager.shared.purchase(subscription.package) { result in
            switch result {
            case .success(_):
                completion(nil)
            case .error(let error):
                completion(error)
            case .userCancelled:
                completion("User cancelled payment")
            }
        }
    }
    
    func verifyPremium(completion: @escaping (String?) -> Void) {
        CoreManager.shared.verifyPremium { result in
            switch result {
            case .premium(_):
                completion(nil)
            case .notPremium:
                completion("Nothing to restore")
            case .error:
                completion("Restore error")
            }
        }
    }
    
    func restore(completion: @escaping (String?) -> Void) {
        CoreManager.shared.restorePremium { result in
            switch result {
            case .premium(_):
                completion(nil)
            case .notPremium:
                completion("Nothing to restore")
            case .error:
                completion("Restore error")
            }
        }
    }
}
