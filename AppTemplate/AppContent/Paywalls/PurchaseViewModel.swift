//
//  PurchaseViewModel.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 14/2/24.
//

import Foundation
import CoreIntegrations

@MainActor
class PurchaseViewModel: ObservableObject {
    @Published var purchases:[Purchase] = []
    @Published var isPremium: Bool = false
    
    func setup(with paywallConfig: PaywallConfig) {
        Task {
            let result = await paywallConfig.purchases()
            switch result {
            case .success(let purchases):
                self.purchases = purchases
            case .error(let error):
                print("ShowError \(error)")
            }
        }
    }
    
    func purchase(purchase: Purchase, source: String, completion: ( (Bool, String) -> Void)? = nil) {
        Task {
            let result = await CoreManager.shared.purchase(purchase)
            switch result {
            case .success(details: let details):
//                UserDefaults.standard.isSubscribed = true
//                AppAnalyticsUserProperties.subscription.identify(parameter: "true")
                completion?(true, "Success")
            case .userCancelled:
                completion?(false, "User cancelled payment")
            case .pending:
                completion?(false, "Payment pending")
            case .unknown:
                completion?(false, "Unknown reason")
            case .error(let error):
                completion?(false, error)
            }
        }
    }
    
    func getPromoOffer(callback: (PromoOffer)->Void) {
        //make a call to the backend and get response with data below
        //PromoOffer(offerID: <#T##String#>, keyID: <#T##String#>, nonce: <#T##UUID#>, signature: <#T##Data#>, timestamp: <#T##Int#>)
        //pass PromoOffer to purchase(purchase: Purchase, promoOffer: PromoOffer function
    }
    
    func purchase(purchase: Purchase, promoOffer: PromoOffer, source: String, completion: ( (Bool, String) -> Void)? = nil) {
        Task {
            let result = await CoreManager.shared.purchase(purchase, promoOffer: promoOffer)
            switch result {
            case .success(details: let details):
//                UserDefaults.standard.isSubscribed = true
//                AppAnalyticsUserProperties.subscription.identify(parameter: "true")
                completion?(true, "Success")
            case .userCancelled:
                completion?(false, "User cancelled payment")
            case .pending:
                completion?(false, "Payment pending")
            case .unknown:
                completion?(false, "Unknown reason")
            case .error(let error):
                completion?(false, error)
            }
        }
    }
    
    func restore(completion: ( (Bool, String) -> Void)? = nil) {
        Task {
            let result = await CoreManager.shared.restore()
            switch result {
            case .restore(let purchases):
                print("")
                if !purchases.isEmpty {
                    if let lifetime = purchases.first(where: {$0.identifier == "lifetime.99.99"}) {
                        //                UserDefaults.standard.isSubscribed = true
                    }
                    
                    completion?(true, "Restore Completed!")
                }else{
                    completion?(false, "Nothing to restore.")
                }
            case .error(let error):
                completion?(false, "Restore failed: \(error)")
            }
        }
    }
    
    func verifyPremium() {
        Task {
            let result = await CoreManager.shared.verifyPremium()
            switch result {
            case .premium(let purchase):
                isPremium = true
            default:
                isPremium = false
            }
        }
    }
    
}
