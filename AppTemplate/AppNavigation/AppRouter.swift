
import SwiftUI

struct AppRouter: View {
    @EnvironmentObject var coordinator: BaseCoordinator

    var body: some View {
        BaseRouterView {
            SplashView()
        }
        .task {
#if DEBUG
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                if UserDefaultsStorage.shared.onboardingPassed {
                    coordinator.push(.content_view)
                } else {
                    coordinator.push(.onboarding1)
                }
            }
#else
            configurePurchases()
            if UserDefaultsStorage.shared.onboardingPassed {
                coordinator.push(.content_view)
            } else {
                coordinator.push(.onboarding1)
            }
#endif
        }
    }
    
    func configurePurchases() {
        _ = Task(timeout: 6) {
            let purchasesManager = AppPurchaseManager.shared
            purchasesManager.configure(allPurchasesIdentifiers: AppPurchaseIdentifier.allIdentifiers)
            await purchasesManager.updateProductsStatus()
            _ = await purchasesManager.verifyPremium()
        }
    }
}
