
import Foundation
import StoreKit
import UIKit

extension PurchasesManager {
    @MainActor
    public func purchase(_ product: Product, activeController: UIViewController?) async throws -> SKPurchaseResult {
        debugPrint("🏦 purchase ⚈ ⚈ ⚈ Purchasing product \(product.displayName)... ⚈ ⚈ ⚈")

        var options:Set<Product.PurchaseOption> = []
        if let userId = UUID(uuidString: self.userId) {
            options = [.appAccountToken(userId)]
        }
        
        var result: Product.PurchaseResult
        
//        if #available (iOS 18.2, *) {
//            if let activeController {
//                 result = try await product.purchase(confirmIn: activeController, options: options)
//            }else{
                 result = try await product.purchase(options: options)
//            }
//        }else{
//             result = try await product.purchase(options: options)
//        }
        
        switch result {
        case .success(let verification):
            debugPrint("🏦 purchase ✅ Product Purchased.")
            debugPrint("🏦 purchase ⚈ ⚈ ⚈ Verifying... ⚈ ⚈ ⚈")
            let transaction = try checkVerified(verification)
            debugPrint("🏦 purchase ✅ Verified.")
            debugPrint("🏦 purchase ⚈ ⚈ ⚈ Updating Product status... ⚈ ⚈ ⚈")
            await updateProductStatus()
            debugPrint("🏦 purchase ✅ Updated product status.")
            await transaction.finish()
            debugPrint("🏦 purchase ✅ Finished transaction.")
            
            let purchaseInfo = SKPurchaseInfo(transaction: transaction, jsonRepresentation: transaction.jsonRepresentation, jwsRepresentation: verification.jwsRepresentation, originalID: "\(transaction.originalID)")
            return .success(transaction: purchaseInfo)
        case .pending:
            debugPrint("🏦 purchase ❌ Failed as the transaction is pending.")
            return .pending
        case .userCancelled:
            debugPrint("🏦 purchase ❌ Failed as the user cancelled the purchase.")
            return .userCancelled
        default:
            debugPrint("🏦 purchase ❌ Failed with result \(result).")
            return .unknown
        }
    }
    
//    public func purchase(_ product: Product, promoOffer:SKPromoOffer) async throws -> SKPurchaseResult {
//        debugPrint("🏦 purchase ⚈ ⚈ ⚈ Purchasing product \(product.displayName)... ⚈ ⚈ ⚈")
//
//        var options:Set<Product.PurchaseOption> = []
//        if let userId = UUID(uuidString: self.userId) {
//            options = [.appAccountToken(userId), .promotionalOffer(offerID: promoOffer.offerID, keyID: promoOffer.keyID, nonce: promoOffer.nonce, signature: promoOffer.signature, timestamp: promoOffer.timestamp)]
//        }else{
//            options = [.promotionalOffer(offerID: promoOffer.offerID, keyID: promoOffer.keyID, nonce: promoOffer.nonce, signature: promoOffer.signature, timestamp: promoOffer.timestamp)]
//        }
//        
//        let result = try await product.purchase(options: options)
//
//        switch result {
//        case .success(let verification):
//            debugPrint("🏦 purchase ✅ Product Purchased.")
//            debugPrint("🏦 purchase ⚈ ⚈ ⚈ Verifying... ⚈ ⚈ ⚈")
//            let transaction = try checkVerified(verification)
//            debugPrint("🏦 purchase ✅ Verified.")
//            debugPrint("🏦 purchase ⚈ ⚈ ⚈ Updating Product status... ⚈ ⚈ ⚈")
//            await updateProductStatus()
//            debugPrint("🏦 purchase ✅ Updated product status.")
//            await transaction.finish()
//            debugPrint("🏦 purchase ✅ Finished transaction.")
//            
//            let purchaseInfo = SKPurchaseInfo(transaction: transaction, jsonRepresentation: transaction.jsonRepresentation, jwsRepresentation: verification.jwsRepresentation, originalID: "\(transaction.originalID)")
//            return .success(transaction: purchaseInfo)
//        case .pending:
//            debugPrint("🏦 purchase ❌ Failed as the transaction is pending.")
//            return .pending
//        case .userCancelled:
//            debugPrint("🏦 purchase ❌ Failed as the user cancelled the purchase.")
//            return .userCancelled
//        default:
//            debugPrint("🏦 purchase ❌ Failed with result \(result).")
//            return .unknown
//        }
//    }
    
    //This call displays a system prompt that asks users to authenticate with their App Store credentials.
    //Call this function only in response to an explicit user action, such as tapping a button.
    public func restore() async -> SKRestoreResult {
        do {
            try await AppStore.sync()
        }
        catch {
            return .error(error.localizedDescription)
        }
        var products:[Product] = []
        products.append(contentsOf: self.purchasedConsumables)
        products.append(contentsOf: self.purchasedNonConsumables)
        products.append(contentsOf: self.purchasedSubscriptions)
        products.append(contentsOf: self.purchasedNonRenewables)
        return .success(products: products)
    }
    
    public func restoreAll() async -> SKRestoreResult {
        let allProducts = await updateAllProductsStatus()
        
        return .success(products: allProducts)
    }
    
    public func verifyPremium() async -> SKVerifyPremiumResult {
        debugPrint("🏦 verifyPremium ⚈ ⚈ ⚈ Verifying... ⚈ ⚈ ⚈")
        await updateProductStatus()
        
        var statuses:[SKVerifyPremiumState] = []
        
        purchasedNonConsumables.forEach { product in
            if proIdentifiers.contains(where: {$0 == product.id}) {
                debugPrint("🏦 verifyPremium ✅ non-consumable \(product.id) status 'purchased' verified")
                let premiumStatus = SKVerifyPremiumState(product: product, state: .subscribed)
                statuses.append(premiumStatus)
            }
        }
        
        purchasedSubscriptions.forEach { product in
            if proIdentifiers.contains(where: {$0 == product.id}) {
                let premiumStatus = SKVerifyPremiumState(product: product, state: .subscribed)
                statuses.append(premiumStatus)
            }
        }
        
        if let premium = statuses.last(where: {$0.state == .subscribed}) {
            debugPrint("🏦 verifyPremium ✅ return active premium product \(premium.product.id) status \(premium.state), \(premium.state.rawValue)")
            return .premium(purchase: premium.product)
        }else{
            return .notPremium
        }
    }
    
    public func verifyAll() async -> SKVerifyAllResult {
        debugPrint("🏦 verifyAll ⚈ ⚈ ⚈ Verifying... ⚈ ⚈ ⚈")
        await updateProductStatus()
        
        debugPrint("🏦 verifyAll ✅ completed! consumables: \(self.purchasedConsumables)\n nonConsumables: \(self.purchasedNonConsumables)\n subscriptions: \(self.purchasedSubscriptions)\n nonRenewables \(self.purchasedNonRenewables)")
        
        var products:[Product] = []
        products.append(contentsOf: self.purchasedConsumables)
        products.append(contentsOf: self.purchasedNonConsumables)
        products.append(contentsOf: self.purchasedSubscriptions)
        products.append(contentsOf: self.purchasedNonRenewables)
        return .success(products: products)
    }
}
