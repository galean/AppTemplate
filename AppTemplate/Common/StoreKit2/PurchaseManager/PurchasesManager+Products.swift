
import Foundation
import StoreKit

extension PurchasesManager {
    public func requestProducts(_ identifiers: [String]) async -> SKProductsResult {
        debugPrint("🏦 requestProducts ⚈ ⚈ ⚈ Requesting products... ⚈ ⚈ ⚈")
        guard !identifiers.isEmpty else {
            debugPrint("🏦 requestProducts ❌ Failed: identifiers are empty.")
            return .error(error: "empty identifiers")
        }
        
        do {
            let storeProducts = try await Product.products(for: identifiers)
            debugPrint("🏦 requestProductsForPaywall ✅ Completed gathering Products.")

            debugPrint("🏦 requestProductsForPaywall ✅ Completed updating available Products.")
            return .success(products: storeProducts)
        } catch {
            debugPrint("🏦 requestProductsForPaywall ❌ Failed product request from the App Store server: \(error).")
            return .error(error: error.localizedDescription)
        }
    }
    
    public func requestAllProducts(_ identifiers: [String]) async -> SKProductsResult {
        debugPrint("🏦 requestAllProducts ⚈ ⚈ ⚈ Requesting products... ⚈ ⚈ ⚈")
        guard !identifiers.isEmpty else {
            debugPrint("🏦 requestAllProducts ❌ Failed: identifiers are empty.")
            return .error(error: "empty identifiers")
        }
        
        do {
            let storeProducts = try await Product.products(for: identifiers)
            debugPrint("🏦 requestAllProducts ✅ Completed gathering Products.")
            
            allAvailableProducts = storeProducts
            
            mapProducts(storeProducts)

            debugPrint("🏦 requestAllProducts ✅ Completed updating available Products.")
            return .success(products: storeProducts)
        } catch {
            debugPrint("🏦 requestAllProducts ❌ Failed product request from the App Store server: \(error).")
            return .error(error: error.localizedDescription)
        }
    }
    
    private func mapProducts(_ storeProducts: [Product]) {
        var newConsumables: [Product] = []
        var newNonConsumables: [Product] = []
        var newSubscriptions: [Product] = []
        var newNonRenewables: [Product] = []

        for product in storeProducts {
            switch product.type {
            case .consumable:
                newConsumables.append(product)
                debugPrint("🏦 mapProducts ✅ Found consumable : \(product).")
            case .nonConsumable:
                newNonConsumables.append(product)
                debugPrint("🏦 mapProducts ✅ Found non-consumable : \(product).")
            case .autoRenewable:
                newSubscriptions.append(product)
                debugPrint("🏦 mapProducts ✅ Found auto-renewable subscription : \(product).")
            case .nonRenewable:
                debugPrint("🏦 mapProducts ✅ Found non-renewable subscription : \(product).")
                newNonRenewables.append(product)
            default:
                debugPrint("🏦 mapProducts ❌ unknown product : \(product).")
            }
        }

        debugPrint("🏦 mapProducts ✅ Completed ordering Products.")

        consumables = sortByPrice(newConsumables)
        nonConsumables = sortByPrice(newNonConsumables)
        subscriptions = sortByPrice(newSubscriptions)
        nonRenewables = sortByPrice(newNonRenewables)
    }

    private func sortByPrice(_ products: [Product]) -> [Product] {
        products.sorted(by: { return $0.price < $1.price })
    }
}
