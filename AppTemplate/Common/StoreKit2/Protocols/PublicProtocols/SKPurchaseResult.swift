
import Foundation
import StoreKit

public enum SKPurchaseResult {
    case success(transaction: SKPurchaseInfo)
    case pending
    case userCancelled
    case unknown
}
