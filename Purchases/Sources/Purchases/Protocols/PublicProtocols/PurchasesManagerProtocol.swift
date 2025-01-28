
import Foundation
import StoreKit

public protocol PurchasesManagerProtocol {
    static var shared: PurchasesManagerProtocol { get }
    func initialize(allIdentifiers: [String])
    func requestProducts(_ identifiers: [String]) async -> SKProductsResult
    func requestAllProducts(_ identifiers: [String]) async -> SKProductsResult
    func updateProductStatus() async
    func purchase(_ product: Product, activeController: UIViewController?) async throws -> SKPurchaseResult
    func restore() async -> SKRestoreResult
    func restoreAll() async -> SKRestoreResult
    func verifyPremium() async -> SKVerifyPremiumResult
}
