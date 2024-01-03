//
//  CoreManager.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 03.10.2023.
//

import Foundation
import CoreIntegrations

class AppCoreManager {
    static var shared = AppCoreManager()
        
    var configurationFinished: Bool = false
    var configurationResult: CoreManagerResult?
    var configurationFinishCompletion: (() -> Void)? {
        didSet {
            if configurationFinished {
                configurationFinishCompletion?()
            }
        }
    }
}

extension AppCoreManager: CoreManagerDelegate {
    func coreConfigurationFinished(result: CoreManagerResult) {
        if result.userSource == .ipat {
            //set internal values for ipat
        }
        print("coreConfigurationFinished \(result)")
        configurationResult = result
        configurationFinished = true
        configurationFinishCompletion?()
    }
    
    func appUpdateRequired(result: ForceUpdateResult) {
        /*
         result.currentVersion:String = "1.0.0"
         result.newVersion:String = "1.1.0"
         result.appUpdateRequired:Bool = true
         
         if result.appUpdateRequired {
            presentAlert()
         }
         */
    }
}

/*
 private func presentAlert() {
     alertIsShown = true
     let vc = UIViewController()
     let navVC = UINavigationController(rootViewController: vc)

     UIApplication.topViewController()?.present(createForceUpdateAlert(), animated: true)
 }
 
 private func createForceUpdateAlert() -> UIAlertController {
     let title = "Need version update"
     let message = "Recently we've significantly improved the app's quality by adding new features. Past versions no longer have support, so please update to the current version"
     let update = "Update"
     let appURLString = "https://apps.apple.com/es/app/tape-measure-app-ar-ruler-3d/id1564249382" <-- change it
     let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
     alertController.addAction(UIAlertAction(title: update, style : UIAlertAction.Style.cancel, handler: { action in
         self.alertIsShown = false
         self.presentAlert()
         UIApplication.shared.open(URL(string: appURLString)!)
     }))
     return alertController
 }
 
 extension UIApplication {

     class func topViewController(base: UIViewController? = UIApplication.shared.windows.first { $0.isKeyWindow }?.rootViewController) -> UIViewController? {

         if let nav = base as? UINavigationController {
             return topViewController(base: nav.visibleViewController)

         } else if let tab = base as? UITabBarController, let selected = tab.selectedViewController {
             return topViewController(base: selected)

         } else if let presented = base?.presentedViewController {
             return topViewController(base: presented)
         }
         return base
     }
 }

 */
