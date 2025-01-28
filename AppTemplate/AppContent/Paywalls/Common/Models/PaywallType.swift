import Foundation

enum PaywallType: String, CaseIterable {
    case somePaywall = "somePaywall"
    
    var id: String { return rawValue }

    var purchases: [AppPurchaseIdentifier] {
        switch self {
        case .somePaywall:
            return [.somePurchase]
        }
    }
}

extension PaywallType {
    static var allPurchasesIDs: [String] {
        return allPurchases.map({$0.id})
    }
    
    static var allPurchases: [AppPurchaseIdentifier] {
        return AppPurchaseIdentifier.allCases
    }
    
    var activeForPaywallIDs: [String] {
        return purchases.map({$0.id})
    }
    
    var allPurchases: [AppPurchaseIdentifier] {
        return AppPurchaseIdentifier.allCases
    }
}
