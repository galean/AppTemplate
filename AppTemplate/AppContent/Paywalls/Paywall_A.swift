//
//  Paywall_A.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI

struct Paywall_A: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let paywallID = "ct_vap_1"
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
    Paywall_A(screenSource: "onboarding") { result in }
}
