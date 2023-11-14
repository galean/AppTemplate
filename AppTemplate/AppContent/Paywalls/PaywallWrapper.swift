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

class PaywallWrapper: NSObject {
    /*
     if RemoteABTests.special_offer_shown.boolValue && !PaywallWrapper.exceptPaywalls.contains(.ct_vap_2) {
                //show special offer
     }
     */
    static let exceptPaywalls:[PaywallType] = [.ct_vap_1, .ct_vap_3]
    
    static func show(from source: String, onClose: PaywallResultClosure? = nil) -> UIViewController {
        let rootvc = vc(source, onClose)
        rootvc.modalPresentationStyle = .fullScreen
        rootvc.screenSource = source
        rootvc.view.backgroundColor = .white
        return rootvc
    }
    
    static func show(from source: String, onClose: PaywallResultClosure? = nil) -> some View {
        view(source, onClose)
    }
    
    private static var active_paywall: PaywallType {
        return PaywallType.allCases.first(where: {$0.id == AppCoreManager.shared.configurationResult?.activePaywallName}) ?? .ct_vap_1
    }
    
    //use SwiftUI view in UIKit project
    private static func vc(_ source: String, _ closeResult: PaywallResultClosure? = nil) -> UIViewController {
        switch active_paywall {
        case .ct_vap_1:
            return represent(Paywall_A(screenSource: source, closeResult:closeResult))
        case .ct_vap_2:
            return represent(Paywall_B(screenSource: source, closeResult:closeResult))
        case .ct_vap_3:
            let ct_vap_3 = Paywall_UIKit()
            ct_vap_3.closeResult = closeResult
            return ct_vap_3
        }
    }
    
    //use SwiftUI view in SwiftUI project
    private static func view(_ source: String, _ closeResult: PaywallResultClosure? = nil) -> some View {
        Group {
            switch active_paywall {
            case .ct_vap_1:
                 Paywall_A(screenSource: source, closeResult:closeResult)
            case .ct_vap_2:
                 Paywall_B(screenSource: source, closeResult:closeResult)
            case .ct_vap_3:
                // Representable container
                Paywall_UIKitRepresentable(closeResult: closeResult)
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
