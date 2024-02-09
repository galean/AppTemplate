//
//  Router.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import UIKit

typealias NavigationBackClosure = (() -> Void)

protocol RouterProtocol: AnyObject {
    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack: NavigationBackClosure?)
    func push(_ drawable: Drawable, animation: UIView.AnimationOptions, onNavigateBack: NavigationBackClosure?)
    func push(_ items: [(drawable: Drawable, backClosure: NavigationBackClosure?)], isAnimated: Bool)

    func switchTo(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?)
    func pop(_ isAnimated: Bool)
    func pop(_ popController: Drawable, isAnimated: Bool) // don't know what it does
    func pop(to drawable: Drawable, isAnimated: Bool)
    func popToRoot(_ isAnimated: Bool)

    var isNotRootViewController: Bool { get }
}

class Router: NSObject, RouterProtocol {
    let navigationController: UINavigationController
    private var closures = [String: NavigationBackClosure]()

    var isNotRootViewController: Bool {
        return navigationController.viewControllers.count > 1
    }

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        super.init()
        self.navigationController.delegate = self
    }

    deinit {
        debugPrint("DEINITED \(String(describing: self))")
    }

    func push(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else { return }

        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }

        self.navigationController.pushViewController(viewController, animated: isAnimated)
    }

    func push(_ drawable: Drawable, animation: UIView.AnimationOptions, onNavigateBack closure: NavigationBackClosure?) {
        guard let viewController = drawable.viewController else { return }

        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }
        UIView.transition(with: self.navigationController.view, duration: 0.2, options: animation) {
            self.navigationController.pushViewController(viewController, animated: false)
        }
    }

    func push(_ items: [(drawable: Drawable, backClosure: NavigationBackClosure?)], isAnimated: Bool) {
        let viewControllers = items.compactMap { $0.drawable.viewController }
        items.forEach { item in
            if let closure = item.backClosure, let key = item.drawable.viewController?.description {
                closures.updateValue(closure, forKey: key)
            }
        }
        let currentControllers = navigationController.viewControllers
        self.navigationController.setViewControllers(currentControllers + viewControllers, animated: isAnimated)
    }

    func pop(_ isAnimated: Bool) {
        self.navigationController.popViewController(animated: isAnimated)
    }

    func popToRoot(_ isAnimated: Bool) {
        guard let viewControllers = navigationController.popToRootViewController(animated: isAnimated) else { return }
        viewControllers.forEach { executeClosure($0) }
    }

    func pop(_ popController: Drawable, isAnimated: Bool) {
        var previousController: UIViewController?
        var isPreviousControllersEnded = false
        for viewController in navigationController.viewControllers {
            if !isPreviousControllersEnded {
                if viewController != popController.viewController {
                    previousController = viewController
                } else {
                    isPreviousControllersEnded = true
                }
            }
        }
        guard let previousController = previousController else {
            return
        }
        guard let viewControllers = self.navigationController.popToViewController(previousController, animated: true) else { return }
        viewControllers.forEach { executeClosure($0) }
    }

    func pop(to drawable: Drawable, isAnimated: Bool) {
        guard let controller = drawable.viewController else { return }
        if !navigationController.viewControllers.contains(controller) {
            print("❌ Current navigation stack not contain: \(controller). It mean yor controller can be in tab container, provide root contoller for this case")
            return
        }

        guard let viewControllers = self.navigationController.popToViewController(controller, animated: true) else { return }
        viewControllers.forEach { executeClosure($0) }
    }

    func switchTo(_ drawable: Drawable, isAnimated: Bool, onNavigateBack closure: NavigationBackClosure?) {
        // Get all controllers
        var currentControllers = navigationController.viewControllers

        // Get top and new
        guard let topController = currentControllers.last,
              let topControllerIdx = currentControllers.firstIndex(of: topController),
              let viewController = drawable.viewController
        else { return }

        // Execute close closure (relese coordinator) and remove from top
        executeClosure(topController)
        currentControllers.remove(at: topControllerIdx)

        // Save new closure for new controller
        if let closure = closure {
            closures.updateValue(closure, forKey: viewController.description)
        }

        // Append new controller
        currentControllers += [viewController]

        // Set new stack
        navigationController.setViewControllers(currentControllers, animated: isAnimated)
    }

    private func executeClosure(_ viewController: UIViewController) {
        guard let closure = closures.removeValue(forKey: viewController.description) else { return }
        closure()
    }
}

extension Router: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let previousController = navigationController.transitionCoordinator?.viewController(forKey: .from),
            !navigationController.viewControllers.contains(previousController) else {
                return
        }
        executeClosure(previousController)
    }
}
