//
//  BaseCoordinator.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
}

typealias PaywallCoordinator = Coordinator & Drawable

extension Coordinator {
    func store(coordinator: Coordinator) {
        childCoordinators.append(coordinator)
        debugPrint("STORE \(String(describing: coordinator))")
    }
    
    func free(coordinator: Coordinator) {
        childCoordinators = childCoordinators.filter { $0 !== coordinator }
        debugPrint("FREE \(String(describing: coordinator))")
    }
}

class BaseCoordinator: Coordinator {
    var childCoordinators : [Coordinator] = []
    
    deinit {
        debugPrint("DEINITED \(String(describing: self))")
    }
}

//MARK: - WebView
extension BaseCoordinator {
    func showWebView(root: Drawable, source: WebViewViewModel.WebViewModel) {
        let navigationController = UINavigationController()
        navigationController.modalPresentationStyle = .fullScreen
        
        let router = Router(navigationController: navigationController)
        let routerModal = RouterModal(root: root)
        let coordinator = WebViewCoordinator(routerModal: routerModal, source: source)
        store(coordinator: coordinator)
        
        router.push(coordinator, isAnimated: false, onNavigateBack: nil)
        routerModal.present(navigationController, isAnimated: true) { [weak self, weak coordinator] in
            guard let `self` = self, let coordinator = coordinator else { return }
            self.free(coordinator: coordinator)
        }
    }
}

//MARK: - PAYWALL
extension BaseCoordinator {
    func showPaywall(root: Drawable, container: DIContainer, screenSource: String, onDismiss: EmptyBlock? = nil) {
        let routerModal = RouterModal(root: root)
        let coordinator = PaywallFactory.create(
            routerModal: routerModal,
            container: container,
            type: PaywallConfig.activePaywall,
            screenSource: screenSource,
            onDismiss: onDismiss
        )
        coordinator.viewController?.modalPresentationStyle = .fullScreen
        store(coordinator: coordinator)
        
        routerModal.present(coordinator, isAnimated: true) { [weak self, weak coordinator] in
            guard let `self` = self, let coordinator = coordinator else { return }
            self.free(coordinator: coordinator)
        }
    }
}

extension BaseCoordinator {
    // Restart app coordinator by current states
    func restartAppCoordinator() {
        let scene = UIApplication.shared.connectedScenes.first
        let app = scene?.delegate as? SceneDelegate
        app?.appCoordinator?.start()
    }
}
