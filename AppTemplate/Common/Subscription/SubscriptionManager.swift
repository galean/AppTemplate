//
//  SubscriptionManager.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 20.02.2023.
//

import Foundation
import CoreIntegrations

final class SubscriptionManager {
    static let shared = SubscriptionManager()
    private init() { }
    
    func subscriptions(for paywall: String, completion: @escaping ([Subscription]?) -> Void) {
        CoreManager.shared.offerings { offerings in
            guard let offering = offerings?[paywall] else {completion(nil); return}
            var subscriptions:[Subscription]?
            offering.availablePackages.forEach { package in
                let product = package.storeProduct
                
                let isSubscription = product.productType == .autoRenewableSubscription || product.productType == .nonRenewableSubscription
                
                let subscription = Subscription(isSubscription: isSubscription, package: package, price: product.priceFloat, periodString: product.periodString, trialPrice: product.introPrice, trialPeriodstring: product.trialPeriodString, trialCount: product.trialCount, currencyCode: product.currencyCode ?? "", localisedPrice: package.localizedPriceString, localisedTrialPrice: package.localizedIntroductoryPriceString, type: SubscriptionType(rawValue: package.packageType.rawValue) ?? .unknown)
                
                subscriptions?.append(subscription)
            }
            completion(subscriptions)
        }
    }
    
    func purchase(subscription: Subscription, completion: @escaping (String?) -> Void) {
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
    
}

