//
//  UIApplication.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import UIKit

// MARK: - UIWindow
extension UIWindow {
    static var main: UIWindow? {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow })
    }
}

extension UIApplication {
    var topController: UIViewController? {
        return topViewController()
    }

    private func topViewController(_ base: UIViewController? = nil) -> UIViewController? {
        let baseController = base ?? UIWindow.main?.rootViewController
        if let navigationController = baseController as? UINavigationController {
            return topViewController(navigationController.visibleViewController)
        }
        if let tabBarController = baseController as? UITabBarController {
            if let selected = tabBarController.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presentedViewController = baseController?.presentedViewController {
            return topViewController(presentedViewController)
        }
        if baseController == nil {
            return UIWindow.main?.rootViewController
        }
        return baseController
    }
}
