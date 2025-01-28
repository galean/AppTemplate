import Foundation
import Purchases
import StoreKit

public enum CorePaywallPurchasesResult {
    case success(purchases: [Purchase])
    case error(_ error: String)
}

public enum PurchasesPurchaseResult {
    case success(details: PurchaseDetails)
    case userCancelled
    case pending
    case unknown
    case error(_ error: String)
}

public enum PurchasesVerifyPremiumResult {
    case premium(purchase: Purchase)
    case notPremium
}

public enum PurchasesRestoreResult {
    case restore(purchases: [Purchase])
    case error(_ error: String)
}


public struct PurchaseDetails {
    public let productId: String
    public let product: Product
    public let transaction: Transaction
    public let jws: String?
    public let originalTransactionID: String?
    public let decodedTransaction: Data?
    
    
    public init(productId: String, product: Product, transaction: Transaction, jws: String?, originalTransactionID: String?, decodedTransaction: Data?) {
        self.productId = productId
        self.product = product
        self.transaction = transaction
        self.jws = jws
        self.originalTransactionID = originalTransactionID
        self.decodedTransaction = decodedTransaction
    }
}

class AppPurchaseManager {
    static var shared: AppPurchaseManager = AppPurchaseManager()
    var purchasesManager = PurchasesManager.shared
    
    private init() {
        
    }
    
    // MARK: Private Methods
    
    private func mapProducts(_ products: [Product], _ config: PaywallType) -> [Purchase] {
        var purchases: [Purchase] = []
        products.forEach { product in
            let purchase = Purchase(product: product)
            purchases.append(purchase)
        }
        return purchases
    }
    
    private func sortPurchases(_ purchases: [Purchase], ids: [String]) -> [Purchase] {
        return purchases.sorted { f, s in
            guard let first = ids.firstIndex(of: f.identifier) else {
                return false
            }

            guard let second = ids.firstIndex(of: s.identifier) else {
                return true
            }

            return first < second
        }
    }
    
    // MARK: Public methods

    func configure(allPurchasesIdentifiers: [String]) {
        purchasesManager = PurchasesManager.shared
        purchasesManager.initialize(allIdentifiers: allPurchasesIdentifiers)
    }
    
    func updateProductsStatus() async {
        await purchasesManager.updateProductStatus()
    }
    
    func purchases(for paywall: PaywallType) async -> CorePaywallPurchasesResult {
        let result = await purchasesManager.requestProducts(paywall.activeForPaywallIDs)
        switch result {
        case .success(let products):
            var purchases = mapProducts(products, paywall)
            purchases = sortPurchases(purchases, ids: paywall.activeForPaywallIDs)
            return .success(purchases: purchases)
        case .error(let error):
            return .error(error)
        }
    }
    
    @MainActor
    public func purchase(_ purchase: Purchase) async -> PurchasesPurchaseResult {
        let result = try? await purchasesManager.purchase(purchase.product, activeController: nil)

        switch result {
        case .success(let purchaseInfo):
            let details = PurchaseDetails(productId: purchase.product.id, product: purchase.product, transaction: purchaseInfo.transaction, jws: purchaseInfo.jwsRepresentation, originalTransactionID: purchaseInfo.originalID, decodedTransaction: purchaseInfo.jsonRepresentation)
            return .success(details: details)
        case .pending:
            return .pending
        case .userCancelled:
            return .userCancelled
        case .unknown:
            return .unknown
        case .none:
            return .unknown
        }
    }
    
    public func verifyPremium() async -> PurchasesVerifyPremiumResult {
        let result = await purchasesManager.verifyPremium()
        if case .premium(let product) = result {
            return .premium(purchase: Purchase(product: product))
        } else {
            return .notPremium
        }
    }
    
    public func restore() async -> PurchasesRestoreResult {
        let result = await purchasesManager.restore()
        
        switch result {
        case .success(products: let products):
            let purchases = products.map({Purchase(product: $0)})
            return .restore(purchases: purchases)
        case .error(let error):
            return .error(error)
        }
    }
}
