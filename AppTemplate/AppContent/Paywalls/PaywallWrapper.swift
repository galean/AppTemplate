//
//  PaywallWrapper.swift
//  AppTemplate
//
//  Created by Anatolii Kanarskyi on 10/11/23.
//

import SwiftUI

public protocol PaywallProtocol {
    var paywallID: String { get }
}

typealias PaywallResultClosure = ((PaywallCloseResult) -> Void)

enum PaywallCloseResult {
    case close
    case purchase
    case showSpecialOffer
}

enum PaywallType: String, CaseIterable {
    //the same values as remote console has
    case ct_vap_1 = "ct_vap_1"
    case ct_vap_2 = "ct_vap_2"
    case ct_vap_3 = "ct_vap_3"
    
    //use SwiftUI view in UIKit project
    func vc(_ source: String, _ closeResult: PaywallResultClosure? = nil) -> UIViewController {
        switch self {
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
    func view(_ source: String, _ closeResult: PaywallResultClosure? = nil) -> some View {
        Group {
            switch self {
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
    private func represent(_ view: some View) -> UIViewController {
        let hostingController = HostingController(rootView: view )
        hostingController.modalPresentationStyle = .fullScreen
        return hostingController
    }
    
}

class PaywallWrapper: NSObject {
    /*
     if RemoteABTests.special_offer_shown.boolValue && !PaywallWrapper.exceptPaywalls.contains(.ct_vap_2) {
                //show special offer
     }
     */
    static let exceptPaywalls:[PaywallType] = [.ct_vap_1, .ct_vap_3]
    
    static func show(from source: String, onClose: PaywallResultClosure? = nil) -> UIViewController {
        let rootvc = active_paywall.vc(source, onClose)
        rootvc.modalPresentationStyle = .fullScreen
        rootvc.screenSource = source
        rootvc.view.backgroundColor = .white
        return rootvc
    }
    
    static func show(from source: String, onClose: PaywallResultClosure? = nil) -> some View {
        active_paywall.view(source, onClose)
    }
    
    private static var active_paywall: PaywallType {
        return PaywallType.allCases.first(where: {$0.rawValue == AppCoreManager.shared.configurationResult?.activePaywallName}) ?? .ct_vap_1
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
