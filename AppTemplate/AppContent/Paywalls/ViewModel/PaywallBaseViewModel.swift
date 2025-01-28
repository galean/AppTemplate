import Foundation

@MainActor
class PaywallBaseViewModel: ObservableObject {
    @Published var purchases: [Purchase] = []
    @Published var isPremium: Bool = false
    
    func setup(with paywallType: PaywallType) {
        Task {
            let result = await AppPurchaseManager.shared.purchases(for: paywallType)
            switch result {
            case .success(let purchases):
                self.purchases = purchases
            case .error(let error):
                print("ShowError \(error)")
            }
        }
    }
    
    func purchase(purchase: Purchase) async -> Bool {
        let result = await AppPurchaseManager.shared.purchase(purchase)
        switch result {
        case .success:
            isPremium = true
        default:
            break
        }
        return isPremium
    }
    
    func restore() {
        Task {
            let result = await AppPurchaseManager.shared.restore()
            switch result {
            case .restore( _):
                isPremium = true
            case .error( _):
                //show nothing to restore alert
                break
            }
        }
    }
}
