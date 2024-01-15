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
            
            Text("Hello, Paywall_A!")
      
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
            
            //get promo offers async
            Task {
                let promoOffers = await paywallConfig.promoOffers(for:self.purchases.first!)
            }
        }
          
    }
    
    private func purchase(_ purchase: Purchase, _ promo: PromoOffer) {
        AppAnalyticsEvents.subscription_subscribe_clicked.log()
        
        //async
        Task {
            let purchase = await CoreManager.shared.purchase(purchase, promo)
        }
        //or callback
        CoreManager.shared.purchase(purchase, promo) { result in
            
        }
    }
    
    private func restore() {
        AppAnalyticsEvents.subscription_restore_clicked.log()
        
        CoreManager.shared.restorePremium { result in
            
        }
    }
}

#Preview {
    Paywall_A(screenSource: "onboarding") { result in }
}
