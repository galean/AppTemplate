import Foundation

enum AppPurchaseIdentifier: String, CaseIterable {
    case somePurchase = "somePurchase_id"
    
    var id: String { return rawValue }
    
    static var allIdentifiers: [String] {
        self.allCases.map { $0.id }
    }
}
