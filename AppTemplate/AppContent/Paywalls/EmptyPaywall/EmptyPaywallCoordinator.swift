//
//  EmptyPaywallCoordinator.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//  Copyright (c) 2024. All rights reserved.
//

import UIKit

protocol PaywallCoordinatorDelegate: AnyObject {
    func dismiss()
    func showWebView(source: WebViewViewModel.WebViewModel)
}

class EmptyPaywallCoordinator: BaseCoordinator {
    private let routerModal: RouterModalProtocol
    private let controller: UIViewController
    
    init(routerModal: RouterModalProtocol, container: DIContainer, screenSource: String) {
        self.routerModal = routerModal
        let viewModel = EmptyPaywallViewModel()
        controller = EmptyPaywallView(viewModel: viewModel).makeViewController()
        super.init()
        viewModel.coordinator = self
    }
}

extension EmptyPaywallCoordinator: PaywallCoordinatorDelegate {
    func dismiss() {
        routerModal.dismiss(self, isAnimated: true)
    }
    
    func showWebView(source: WebViewViewModel.WebViewModel) {
        showWebView(root: self, source: source)
    }
}

extension EmptyPaywallCoordinator: Drawable {
    var viewController: UIViewController? { return controller }
}
