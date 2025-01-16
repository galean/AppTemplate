//
//  AppDestination.swift
//  NavDemo
//
//  Created by Anatolii Kanarskyi on 13.01.2025.
//

import SwiftUI

enum AppDestination: String, Hashable, Identifiable {
    case splash = "splash"
    case onboarding1 = "onboarding1"
    case onboarding2 = "onboarding2"
    case onboarding3 = "onboarding3"
    case paywall = "paywall"
    case content_view = "content_view"
    case settings = "detailView"
    
    var id: String {
        rawValue
    }
    
    var view: some View {
        Group {
            switch self {
            case .splash: SplashView()
            case .onboarding1: OnboardingView_1()
            case .onboarding2: OnboardingView_2()
            case .onboarding3: OnboardingView_3()
            case .paywall:
                PaywallFactory.create(from: "source") { result in
                    print("PaywallResult \(result)")
                }
            case .content_view: ContentView()
            case .settings: SettingsView()
            }
        }
    }
    
}
