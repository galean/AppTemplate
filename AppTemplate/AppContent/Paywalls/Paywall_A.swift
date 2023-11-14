//
//  Paywall_A.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI

struct Paywall_A: View, PaywallViewProtocol {
    
    @Environment(\.dismiss) var dismiss
    
    let paywallIdentifier:PaywallType = .ct_vap_1
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
      
            ForEach(paywallIdentifier.subscriptions, id: \.self){ subscription in
                Text("Subscribe for: \(subscription.localisedPrice)/\(subscription.periodString)")
            }
            
            Spacer()
            
            Button(action: {
                dismiss()
                closeResult?(.purchase)
            }) {
                Text("Subscribe")
            }
        }
          
    }
    
    func purchase(_ subscription: Purchase) {
        paywallIdentifier.purchase(subscription: subscription) { status in
            
        }
    }
    
    func restore() {
        paywallIdentifier.restore { status in
            
        }
    }
}

#Preview {
    Paywall_A(screenSource: "onboarding") { result in }
}
