//
//  AppCoordinator.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import UIKit

enum AppFlow: String {
    case onboarding
    case main
}

class AppCoordinator: BaseCoordinator {
    private let window: UIWindow
    private let container: DIContainer
    
    private lazy var appLoaderScreen: UIViewController = {
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        let router = Router(navigationController: navigationController)
        let coordinator = LaunchCoordinator(router: router, container: container)
        store(coordinator: coordinator)
        coordinator.start()
        router.push(coordinator, isAnimated: false, onNavigateBack: nil)
        
        coordinator.configurationEnd = { [weak self] in
            DispatchQueue.main.async {
                self?.selectFlow()
            }
        }
        
        return navigationController
    }()
    
    init(window: UIWindow, container: DIContainer) {
        self.window = window
        self.container = container
        super.init()
    }
    
    func start() {
        showLoaderScreen()
    }
    
    private func selectFlow() {
        showMain()
    }
    
    private func showLoaderScreen() {
        set(appLoaderScreen)
    }
    
    private func showOnboarding() {
        childCoordinators = []
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)

        setRoot(navigationController)
    }
    
    private func showMain() {
        childCoordinators = []
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)

        setRoot(navigationController)
    }
}

extension AppCoordinator {
    private func set(_ controller: UIViewController) {
        window.rootViewController = controller
        window.makeKeyAndVisible()
    }

    private func setRoot(_ controller: UIViewController) {
        if window.rootViewController == nil {
            set(controller)
            return
        }

        let snapshot = window.snapshotView(afterScreenUpdates: true)!
        controller.view.addSubview(snapshot)
        set(controller)

        UIView.transition(with: snapshot, duration: baseAppRefreshAnimation, options: .transitionCrossDissolve, animations: {
            snapshot.layer.opacity = .zero
            snapshot.layer.transform = CATransform3DMakeScale(1.3, 1.3, 1.3)
        }, completion: { _ in
            snapshot.removeFromSuperview()
        })
    }
}
