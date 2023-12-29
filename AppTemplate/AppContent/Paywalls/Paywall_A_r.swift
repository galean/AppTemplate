//
//  Paywall_A_r.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 29/12/23.
//

import SwiftUI
import CoreIntegrations

//MARK: Paywall for review
struct Paywall_A_r: View, PaywallViewProtocol {
   
    @Environment(\.dismiss) var dismiss
    @State var purchases: [Purchase] = []
    
    let paywallConfig:PaywallConfig = .ct_vap_1
    let screenSource: String
    let closeResult: PaywallResultClosure?
    
    var body: some View {
        VStack {
            Button(action: {
                dismiss()
                closeResult?(.close)
            }) {
                Text("Close")
            }
            
            Spacer()
            
            Text("Hello, Paywall_A_r!")
      
            ForEach(purchases, id: \.self){ purchase in
                Text("Subscribe for: \(purchase.localisedPrice)/\(purchase.periodString)")
            }
            
            Spacer()
            
            Button(action: {
                dismiss()
                closeResult?(.purchase)
            }) {
                Text("Subscribe")
            }
        }
        .onAppear {
            AppAnalyticsEvents.subscription_shown.log(parameters: ["id":paywallConfig.id])
            
            paywallConfig.purchases { result in
                switch result {
                case .success(let purchases):
                    self.purchases = purchases
                case .error(let error):
                    print("paywallConfig.purchases error \(error)")
                }
                
            }
        }
          
    }
    
    private func purchase(_ purchase: Purchase) {
        AppAnalyticsEvents.subscription_subscribe_clicked.log()
        
        CoreManager.shared.purchase(purchase) { result in
            
        }
    }
    
    private func restore() {
        AppAnalyticsEvents.subscription_restore_clicked.log()
        
        CoreManager.shared.restorePremium { result in
            
        }
    }
}

#Preview {
    Paywall_A_r(screenSource: "onboarding") { result in }
}
