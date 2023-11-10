//
//  ContentView.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 20.02.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var showPaywall = false
    @State var showOffer = false
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("ContentView")
            
            Button(action: {
                showPaywall.toggle()
            }) {
                Text("Show Paywall")
            }
        }
        .padding()
        .fullScreenCover(isPresented: $showPaywall, content: {
            PaywallWrapper.show(from: "onboarding") { result in
                print("PaywallResult \(result)")
                if result == .purchase {
                    //show something...
                }
            }
        })
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
