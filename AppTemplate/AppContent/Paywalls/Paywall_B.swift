//
//  Paywall_B.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI

struct Paywall_B: View {
    
    @Environment(\.dismiss) var dismiss
    
    private let paywallID = "ct_vap_2"
    let screenSource: String
    let closeResult: PaywallResultClosure?
    
    var body: some View {
        Button(action: {
            dismiss()
            closeResult?(.close)
        }) {
            Text("Close")
        }
        
        Spacer()
        
        Text("Hello, Paywall_B!")
        
        Spacer()
        
        Button(action: {
            dismiss()
            closeResult?(.purchase)
        }) {
            Text("Subscribe")
        }
    }
}

#Preview {
    Paywall_B(screenSource: "settings") { result in }
}
