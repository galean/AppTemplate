//
//  Paywall_A.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI
import CoreIntegrations

struct Paywall_A: View, PaywallViewProtocol {
   
    @StateObject var purchaseVM = PurchaseViewModel()
    @EnvironmentObject var coordinator: DefaultNavigationCoordinator
    
    let paywallConfig:PaywallConfig = .ct_vap_1
    let screenSource: String
    let closeResult: PaywallResultClosure?
    
    var body: some View {
        VStack {
            Button(action: {
                dismiss(.close)
            }) {
                Text("Close")
            }
            
            Spacer()
            
            Text("Hello, Paywall_A!")
      
            ForEach(purchaseVM.purchases, id: \.identifier){ purchase in
                Text("Subscribe for: \(purchase.localizedPrice)/\(purchase.periodString)")
            }
            
            Spacer()
            
            Button(action: {
                dismiss(.purchase)
            }) {
                Text("Subscribe")
            }
        }
        .toolbar(.hidden)
        .onAppear {
            AppAnalyticsEvents.subscription_shown.log(parameters: ["id":paywallConfig.id])
            
            purchaseVM.setup(with: paywallConfig)
        }
          
    }
    
    private func purchase(_ purchase: Purchase) {
        AppAnalyticsEvents.subscription_subscribe_clicked.log()
        
        purchaseVM.purchase(purchase: purchase, source: paywallConfig.id) { status, error in
            if status {
                //show success
            }else{
                //show error
            }
        }
    }
    
    private func restore() {
        AppAnalyticsEvents.subscription_restore_clicked.log()
        
        purchaseVM.restore { status, message in
            if status {
                //show success
            }
        }
    }
    
    private func dismiss(_ reason: PaywallCloseResult) {
        if coordinator.presentation == .push {
            coordinator.push(.content_view)
        }else{
            coordinator.dismiss()
        }
        
        closeResult?(reason)
    }
}

#Preview {
    Paywall_A(screenSource: "onboarding") { result in }
}
