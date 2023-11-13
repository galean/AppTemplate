//
//  Paywall_A.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI

struct Paywall_A: View, PaywallProtocol {
    
    @Environment(\.dismiss) var dismiss
    
    let paywallID = "ct_vap_1"
    @State var subscriptions: [Subscription] = []
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
            /*
            ForEach(subscriptions, id: \.self){ subscription in
                Text("Subscribe for: \(subscription.localisedPrice)/\(subscription.periodString)")
            }
            */
            Spacer()
            
            Button(action: {
                dismiss()
                closeResult?(.purchase)
            }) {
                Text("Subscribe")
            }
        }
        .onAppear {
            SubscriptionManager.shared.subscriptions(for: paywallID) { data in
                if let data = data {
                    self.subscriptions = data
                }
            }
        }
    }
}

#Preview {
    Paywall_A(screenSource: "onboarding") { result in }
}
