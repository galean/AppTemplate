
import Foundation
import StoreKit
import UIKit

extension PurchasesManager {
    @MainActor
    public func purchase(_ product: Product, activeController: UIViewController?) async throws -> SKPurchaseResult {
        var options:Set<Product.PurchaseOption> = []
        if let userId = UUID(uuidString: self.userId) {
            options = [.appAccountToken(userId)]
        }
        
        let result = try await product.purchase(options: options)
        
        switch result {
        case .success(let verification):
            let transaction = try checkVerified(verification)
            await updateProductStatus()
            await transaction.finish()
            
            let purchaseInfo = SKPurchaseInfo(transaction: transaction, jsonRepresentation: transaction.jsonRepresentation, jwsRepresentation: verification.jwsRepresentation, originalID: "\(transaction.originalID)")
            return .success(transaction: purchaseInfo)
        case .pending:
            return .pending
        case .userCancelled:
            return .userCancelled
        default:
            return .unknown
        }
    }
    
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
        await updateProductStatus()
        
        var statuses:[SKVerifyPremiumState] = []
        
        purchasedNonConsumables.forEach { product in
            if allIdentifiers.contains(where: {$0 == product.id}) {
                let premiumStatus = SKVerifyPremiumState(product: product, state: .subscribed)
                statuses.append(premiumStatus)
            }
        }
        
        purchasedSubscriptions.forEach { product in
            if allIdentifiers.contains(where: {$0 == product.id}) {
                let premiumStatus = SKVerifyPremiumState(product: product, state: .subscribed)
                statuses.append(premiumStatus)
            }
        }
        
        if let premium = statuses.last(where: {$0.state == .subscribed}) {
            return .premium(purchase: premium.product)
        }else{
            return .notPremium
        }
    }
}
