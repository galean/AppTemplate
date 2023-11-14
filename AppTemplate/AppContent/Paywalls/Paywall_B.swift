//
//  Paywall_B.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI

struct Paywall_B: View, PaywallViewProtocol {
    
    @Environment(\.dismiss) var dismiss
    
    let paywallIdentifier: PaywallType = .ct_vap_2
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
}

#Preview {
    Paywall_B(screenSource: "settings") { result in }
}
