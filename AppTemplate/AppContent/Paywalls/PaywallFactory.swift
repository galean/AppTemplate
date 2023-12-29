//
//  PaywallWrapper.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI
import CoreIntegrations

typealias PaywallResultClosure = ((PaywallCloseResult) -> Void)

enum PaywallCloseResult {
    case close
    case purchase
    case showSpecialOffer
}

class PaywallFactory: NSObject {
    
    static func create(from source: String, onClose: PaywallResultClosure? = nil) -> some View {
        view(source, onClose)
    }
    
    private static var active_paywall: ActivePaywall {
        if let activePaywallName = AppCoreManager.shared.configurationResult?.activePaywallName {
            if activePaywallName.contains("_r") {
                let paywallName = activePaywallName.dropLast("_r".count)
                let paywallConfig = PaywallConfig.allCases.first(where: {$0.id == paywallName}) ?? .ct_vap_1//defaul paywall
                return ActivePaywall(paywallConfig: paywallConfig, isStyleFull: true)
            }else{
                let paywallConfig = PaywallConfig.allCases.first(where: {$0.id == activePaywallName}) ?? .ct_vap_1//defaul paywall
                return ActivePaywall(paywallConfig: paywallConfig, isStyleFull: false)
            }
        }
        
        //return some default paywall
        return ActivePaywall(paywallConfig: .ct_vap_1, isStyleFull: false)
    }
    
    //use SwiftUI view in SwiftUI project
    private static func view(_ source: String, _ closeResult: PaywallResultClosure? = nil) -> some View {
        Group {
            switch active_paywall.paywallConfig {
            case .ct_vap_1:
                active_paywall.isStyleFull ? AnyView(Paywall_A_r(screenSource: source, closeResult:closeResult)) : AnyView(Paywall_A(screenSource: source, closeResult:closeResult))
            case .ct_vap_2:
                active_paywall.isStyleFull ? AnyView(Paywall_B_r(screenSource: source, closeResult:closeResult)) : AnyView(Paywall_B(screenSource: source, closeResult:closeResult))
            case .ct_vap_3:
                // Representable container
                active_paywall.isStyleFull ? AnyView(Paywall_UIKitRepresentable_r(closeResult: closeResult)) : AnyView(Paywall_UIKitRepresentable(closeResult: closeResult))
            }
        }
    }
    
    //create view controller for custom paywall id
    private static func vc(_ paywallID:PaywallConfig, _ source: String, _ closeResult: PaywallResultClosure? = nil) -> UIViewController {
        switch paywallID {
        case .ct_vap_1:
            return represent(active_paywall.isStyleFull ? AnyView(Paywall_A_r(screenSource: source, closeResult:closeResult)) : AnyView(Paywall_A(screenSource: source, closeResult:closeResult)))
        case .ct_vap_2:
            return represent(active_paywall.isStyleFull ? AnyView(Paywall_B_r(screenSource: source, closeResult:closeResult)) : AnyView(Paywall_B(screenSource: source, closeResult:closeResult)))
        case .ct_vap_3:
            if active_paywall.isStyleFull {
                let ct_vap_3 = Paywall_UIKit_r()
                ct_vap_3.closeResult = closeResult
                return ct_vap_3
            }else{
                let ct_vap_3 = Paywall_UIKit()
                ct_vap_3.closeResult = closeResult
                return ct_vap_3
            }
        }
    }
    
    //make UIViewController from SwiftUI View
    private static func represent(_ view: some View) -> UIViewController {
        let hostingController = HostingController(rootView: view )
        hostingController.modalPresentationStyle = .fullScreen
        return hostingController
    }
}

struct ScreenSourceHolder {
    static var source: String?
}

extension UIViewController {
    var screenSource:String? {
        get {
            return ScreenSourceHolder.source
        }
        set(newValue) {
            ScreenSourceHolder.source = newValue
        }
    }
}

class HostingController<ContentView>: UIHostingController<ContentView> where ContentView : View {
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .darkContent
    }
}
