//
//  Paywall_A.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI
import CoreIntegrations

struct Paywall_A: View, PaywallViewProtocol {
   
    @Environment(\.dismiss) var dismiss
    
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
            
            Text("Hello, Paywall_A!")
      
            ForEach(paywallConfig.purchases, id: \.self){ purchase in
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
            //in case of internet absence and empty "paywallConfig.purchases" - request subscriptions again
//            paywallConfig.purchases { purchases in
//
//            }
        }
          
    }
    
    private func purchase(_ purchase: Purchase) {
        CoreManager.shared.purchase(purchase) { result in
            
        }
    }
    
    private func restore() {
        CoreManager.shared.restorePremium { result in
            
        }
    }
}

#Preview {
    Paywall_A(screenSource: "onboarding") { result in }
}
