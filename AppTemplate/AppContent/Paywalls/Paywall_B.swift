//
//  Paywall_B.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI

struct Paywall_B: View, PaywallProtocol {
    
    @Environment(\.dismiss) var dismiss
    
    @State var subscriptions: [Subscription] = []
    let paywallID = "ct_vap_2"
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
    Paywall_B(screenSource: "settings") { result in }
}
