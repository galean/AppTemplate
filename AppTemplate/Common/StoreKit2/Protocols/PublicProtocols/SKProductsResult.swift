
import Foundation
import StoreKit

public enum SKProductsResult {
    case success(products: [Product])
    case error(error: String)
}
