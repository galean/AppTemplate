//
//  ContentView.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 20.02.2023.
//

import SwiftUI

//struct ContentView: View {
//    
//    @State var showPaywall = false
//    @State var showOffer = false
//    @State var isSubscribed = false
//    
//    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            
//            Text("ContentView")
//            Text("isPremium: \(isSubscribed ? "yes" : "no")")
//            
//            Button(action: {
//                showPaywall.toggle()
//            }) {
//                Text("Show Paywall")
//            }
//        }
//        .padding()
//        .fullScreenCover(isPresented: $showPaywall, content: {
//            PaywallFactory.create(from: "onboarding") { result in
//                print("PaywallResult \(result)")
//                isSubscribed = result == .purchase
//            }
//        })
//    
//    }
//}

struct ContentView: View {
    
    @EnvironmentObject var coordinator: DefaultNavigationCoordinator
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    coordinator.fullScreen(.paywall)
                }) {
                    Text("Paywall")
                }
                Spacer()
                Button(action: {
                    coordinator.push(.settings)
                }) {
                    Text("Settings")
                }
            }
            Spacer()
            Text("Content View")
                .font(.system(size: 32, weight: .heavy))
            Spacer()
            Button(action: {
                coordinator.popTo(.onboarding1)
            }) {
                Text("Open Onboarding")
            }
        }
        .padding(.horizontal, 16)
        .background(Color.white)
        .toolbar(.hidden)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
