
import Foundation
import StoreKit

extension PurchasesManager {
    public func isPurchased(_ product: Product) async throws -> Bool {
        switch product.type {
        case .nonRenewable:
            return purchasedNonRenewables.contains(product)
        case .nonConsumable:
            return purchasedNonConsumables.contains(product)
        case .autoRenewable:
            return purchasedSubscriptions.contains(product)
        case .consumable:
            return false
        default:
            debugPrint("🏦 isPurchased ❌ Failed as the type '\(product.type)' is unidentified.")
            return false
        }
    }

    public func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
}

