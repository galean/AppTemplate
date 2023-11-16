//
//  Paywall_B.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI
import CoreIntegrations

struct Paywall_B: View, PaywallViewProtocol {
    
    @Environment(\.dismiss) var dismiss
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
            paywallConfig.purchases { purchases in
                self.purchases = purchases
            }
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
    Paywall_B(screenSource: "settings") { result in }
}
