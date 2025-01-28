import SwiftUI
import Purchases

struct PaywallView: View, PaywallViewProtocol {
    @StateObject var viewModel = PaywallViewModel()
    @EnvironmentObject var coordinator: BaseCoordinator
    
    let paywallConfig: PaywallType = .somePaywall
    let source: PaywallSource
    
    var body: some View {
        VStack {
            Button(action: {
                dismiss()
            }) {
                Text("Close")
            }
            
            Spacer()
            
            Text("Hello, Paywall!")
      
            ForEach(viewModel.purchases, id: \.identifier) { purchase in
                Text("Subscribe for: \(purchase.localizedPrice)/\(purchase.periodString)")
            }
            
            Spacer()
            
            Button(action: {
                Task {
                    #if DEBUG
                    dismiss()
                    #else
                    guard let purchase = viewModel.purchases.first else { return }
                    let success = await viewModel.purchase(purchase: purchase)
                    if success {
                        dismiss()
                    }
                    #endif
                }
            }) {
                Text("Subscribe")
            }
        }
        .toolbar(.hidden)
        .onAppear {            
            viewModel.setup(with: paywallConfig)
        }
    }
    
    private func dismiss() {
        if source != .onboarding {
            coordinator.dismiss()
        } else {
            coordinator.dismiss()
            coordinator.push(.content_view)
        }
    }
}

#Preview {
    PaywallView(source: .onboarding)
}
