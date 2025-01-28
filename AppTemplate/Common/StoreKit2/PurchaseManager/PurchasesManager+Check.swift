
import Foundation
import StoreKit

extension PurchasesManager {
    public func isPurchased(_ product: Product) async throws -> Bool {
        debugPrint("🏦 isPurchased ⚈ ⚈ ⚈ Checking if the product is purchased... ⚈ ⚈ ⚈")
        switch product.type {
        case .nonRenewable:
            debugPrint("🏦 isPurchased ✅ Non-Renewing Subscription has been purchased : \(purchasedNonRenewables.contains(product)).")
            return purchasedNonRenewables.contains(product)
        case .nonConsumable:
            debugPrint("🏦 isPurchased ✅ Non-Consumable has been purchased : \(purchasedNonConsumables.contains(product)).")
            return purchasedNonConsumables.contains(product)
        case .autoRenewable:
            debugPrint("🏦 isPurchased ✅ Auto-Renewable Subscription has been purchased : \(purchasedSubscriptions.contains(product)).")
            return purchasedSubscriptions.contains(product)
        case .consumable:
            debugPrint("🏦 isPurchased ❌ Consumables cannot be checked off as purchased.")
            return false
        default:
            debugPrint("🏦 isPurchased ❌ Failed as the type '\(product.type)' is unidentified.")
            return false
        }
    }

    public func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        debugPrint("🏦 checkVerified ⚈ ⚈ ⚈ Checking verification... ⚈ ⚈ ⚈")
        switch result {
        case .unverified:
            debugPrint("🏦 checkVerified ❌ Not verified.")
            throw StoreError.failedVerification
        case .verified(let safe):
            debugPrint("🏦 checkVerified ✅ Verified.")
            return safe
        }
    }
}

