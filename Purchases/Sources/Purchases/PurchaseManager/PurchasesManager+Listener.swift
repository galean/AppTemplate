
import Foundation
import StoreKit

extension PurchasesManager {
    public func listenForTransactions() -> Task<Void, Error> {
        return Task.detached {
            for await result in Transaction.updates {
                do {
                    let transaction = try self.checkVerified(result)
                    await self.updateProductStatus()
                    await transaction.finish()
                } catch {
                    debugPrint("🏦 listenForTransactions ❌ Transaction verification failed.")
                }
            }
        }
    }
}
