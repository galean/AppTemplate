//
//  Paywall_B.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI
import CoreIntegrations

struct Paywall_B: View, PaywallViewProtocol {
    
    @StateObject var purchaseVM = PurchaseViewModel()
    @EnvironmentObject var coordinator: DefaultNavigationCoordinator
    @State var purchases: [Purchase] = []
    
    let paywallConfig: PaywallConfig = .ct_vap_2
    let screenSource: String
    let closeResult: PaywallResultClosure?
    
    var body: some View {
        VStack{
            Button(action: {
                dismiss()
                closeResult?(.close)
            }) {
                Text("Close")
            }
            
            Spacer()
            
            Text("Hello, Paywall_B!")
            
            ForEach(purchases, id: \.self){ purchase in
                Text("Subscribe for: \(purchase.localizedPrice)/\(purchase.periodString)")
            }
            
            Spacer()
            
            Button(action: {
                dismiss()
                closeResult?(.purchase)
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
    
    private func dismiss() {
        if coordinator.presentation == .push {
            coordinator.push(.content_view)
        }else{
            coordinator.dismiss()
        }
    }
    
}

#Preview {
    Paywall_B(screenSource: "settings") { result in }
}
