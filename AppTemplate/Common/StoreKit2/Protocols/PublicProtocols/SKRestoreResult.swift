
import Foundation
import StoreKit

public enum SKRestoreResult {
    case success(products: [Product])
    case error(_ error: String)
}
