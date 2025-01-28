
import Foundation
import StoreKit

public enum SKVerifyPremiumResult {
    case premium(purchase: Product)
    case notPremium
}
