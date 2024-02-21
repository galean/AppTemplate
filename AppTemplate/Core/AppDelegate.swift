//
//  AppDelegate.swift
//  AppTemplate
//
//  Created by Andrii Plotnikov on 20.02.2023.
//
import Foundation
import UIKit
import CoreIntegrations
import FirebaseIntegration
import AnalyticsIntegration

class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        defaultConfiguration(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func defaultConfiguration(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        CoreManager.shared.application(application,
                                       didFinishLaunchingWithOptions: launchOptions,
                                       coreCofiguration: AppCoreConfiguration(),
                                       coreDelegate: AppCoreManager.shared)
    }

    func application( _ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:] ) -> Bool {
        _ = CoreManager.shared.application(app, open: url, options: options)
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity,
                 restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        let handled = CoreManager.shared.application(application, continue: userActivity,
                                                     restorationHandler: restorationHandler)
        return handled
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        CoreManager.shared.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any],
                 fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        CoreManager.shared.application(application, didReceiveRemoteNotification: userInfo,
                                       fetchCompletionHandler: completionHandler)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        Task {
            let result = await CoreManager.shared.verifyPremium()
            switch result {
            case .premium(let purchase):
                print("UserDefaults.standard.isSubscribed = true")
            case .notPremium:
                print("UserDefaults.standard.isSubscribed = false")
            }
        }
        //or PurchaseViewModel.shared.verifyPremium()
    }
    
}
