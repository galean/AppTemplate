
import Foundation
import StoreKit

extension PurchasesManager {
    
    public func updateAllProductsStatus() async -> [Product] {
        var purchasedAllProducts: [Product] = []
        
        for await result in Transaction.all {
            do {
                let transaction = try checkVerified(result)
                
                switch transaction.productType {
                case .consumable:
                    if let consumable = consumables.first(where: { $0.id == transaction.productID }) {
                        purchasedAllProducts.append(consumable)
                    }
                case .nonConsumable:
                    if let nonConsumable = nonConsumables.first(where: { $0.id == transaction.productID }) {
                        purchasedAllProducts.append(nonConsumable)
                    }
                case .nonRenewable:
                    if let nonRenewable = nonRenewables.first(where: { $0.id == transaction.productID }) {
                        purchasedAllProducts.append(nonRenewable)
                    }
                case .autoRenewable:
                    if subscriptions.isEmpty {
                        let _ =  await requestAllProducts(self.allIdentifiers)
                    }
                    if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedAllProducts.append(subscription)
                    }
                default:
                    debugPrint("🏦 updateCustomerProductStatus ❌ Hit default \(transaction.productID).")
                    break
                }
            } catch {
                debugPrint("🏦 updateCustomerProductStatus ❌ failed to grant product access \(result.debugDescription).")
            }
        }
        return purchasedAllProducts
    }
    
    public func updateProductStatus() async {
        var purchasedConsumables: [Product] = []
        var purchasedNonConsumables: [Product] = []
        var purchasedSubscriptions: [Product] = []
        var purchasedNonRenewableSubscriptions: [Product] = []
        var purchasedAllProducts: [Product] = []

        for await result in Transaction.currentEntitlements {
            do {
                let transaction = try checkVerified(result)

                switch transaction.productType {
                case .consumable:
                    if let consumable = consumables.first(where: { $0.id == transaction.productID }) {
                        purchasedConsumables.append(consumable)
                        purchasedAllProducts.append(consumable)
                    } else {
                        debugPrint("🏦 updateCustomerProductStatus ❌ Consumable Product Id not within the offering : \(transaction.productID).")
                    }
                case .nonConsumable:
                    if let nonConsumable = nonConsumables.first(where: { $0.id == transaction.productID }) {
                        purchasedNonConsumables.append(nonConsumable)
                        purchasedAllProducts.append(nonConsumable)
                    } else {
                        debugPrint("🏦 updateCustomerProductStatus ❌ Non-Consumable Product Id not within the offering : \(transaction.productID).")
                    }
                case .nonRenewable:
                    if let nonRenewable = nonRenewables.first(where: { $0.id == transaction.productID }) {
                        purchasedAllProducts.append(nonRenewable)
                        let currentDate = Date()
                        let expirationDate = Calendar(identifier: .gregorian).date(byAdding: DateComponents(year: 1),
                                                                                   to: transaction.purchaseDate)!

                        if currentDate < expirationDate {
                            purchasedNonRenewableSubscriptions.append(nonRenewable)
                        } else {
                            debugPrint("🏦 updateCustomerProductStatus ❌ Non-Renewing Subscription with Id  \(transaction.productID) expired.")
                        }
                    } else {
                        debugPrint("🏦 updateCustomerProductStatus ❌ Non-Renewing Subscription Product Id not within the offering : \(transaction.productID).")
                    }
                case .autoRenewable:
                    if subscriptions.isEmpty {
                        let _ =  await requestAllProducts(self.allIdentifiers)
                    }
                    if let subscription = subscriptions.first(where: { $0.id == transaction.productID }) {
                        purchasedAllProducts.append(subscription)
                        
                        let status = await transaction.subscriptionStatus
                        if status?.state == .subscribed {
                            purchasedSubscriptions.append(subscription)
                        }
                        if status?.state == .expired {
                            debugPrint("🏦 updateCustomerProductStatus ❌ Auto-Renewable Subscription \(transaction.productID) is expired, skip.")
                        }
                        
                    } else {
                        if subscriptions.isEmpty {
                            debugPrint("🏦 updateCustomerProductStatus ❌ Auto-Renewable Subscriptons array is empty.")
                        }
                        subscriptions.forEach { product in
                            debugPrint("🏦 updateCustomerProductStatus ❌ Auto-Renewable Subscripton Array product: \(product.id).")
                        }
                        debugPrint("🏦 updateCustomerProductStatus ❌ Auto-Renewable Subscripton Product Id not within the offering : \(transaction.productID).")
                    }
                default:
                    debugPrint("🏦 updateCustomerProductStatus ❌ Hit default \(transaction.productID).")
                    break
                }
            } catch {
                debugPrint("🏦 updateCustomerProductStatus ❌ failed to grant product access \(result.debugDescription).")
            }
        }

        self.purchasedConsumables = purchasedConsumables
        self.purchasedNonConsumables = purchasedNonConsumables
        self.purchasedNonRenewables = purchasedNonRenewableSubscriptions
        self.purchasedSubscriptions = purchasedSubscriptions
        self.purchasedAllProducts = purchasedAllProducts
    }
    
    
    
    public func getSubscriptionStatus(product: Product) async -> RenewalState? {
        guard let subscription = product.subscription else {
            // Not a subscription
            return nil
        }
        do {
            let statuses = try await subscription.status
            
            for status in statuses {
                let _ = try checkVerified(status.renewalInfo)
                return status.state
            }
        } catch {
            return nil
        }
        return nil
    }
}
