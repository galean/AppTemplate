import SwiftUI

enum AppDestination: Equatable, Hashable {
    case splash
    case onboarding1
    case onboarding2
    case onboarding3
    case paywall(source: PaywallSource)
    case content_view
    case settings
    
    var view: some View {
        Group {
            switch self {
            case .splash: 
                SplashView()
            case .onboarding1: 
                BaseRouterView { OnboardingView_1() }
            case .onboarding2: 
                OnboardingView_2()
            case .onboarding3: 
                OnboardingView_3()
            case .paywall(let source):
                PaywallView(source: source)
            case .content_view: 
                BaseRouterView { ContentView() }
            case .settings: 
                SettingsView()
            }
        }
    }
    
}

extension AppDestination: Identifiable {
    var id: Self { self }
}
