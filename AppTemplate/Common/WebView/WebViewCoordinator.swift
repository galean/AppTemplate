//
//  WebViewCoordinator.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import UIKit

protocol WebViewCoordinatorDelegate: AnyObject {
    func dismiss()
}

class WebViewCoordinator: BaseCoordinator {
    private let routerModal: RouterModalProtocol
    private let controller: UIViewController
    
    init(routerModal: RouterModalProtocol, source: WebViewViewModel.WebViewModel) {
        self.routerModal = routerModal
        let viewModel = WebViewViewModel(source: source)
        controller = WebViewView(viewModel: viewModel).makeViewController()
        super.init()
        viewModel.coordinator = self
    }
}

extension WebViewCoordinator: WebViewCoordinatorDelegate {
    func dismiss() {
        routerModal.dismiss(self, isAnimated: true)
    }
}

extension WebViewCoordinator: Drawable {
    var viewController: UIViewController? { return controller }
}
