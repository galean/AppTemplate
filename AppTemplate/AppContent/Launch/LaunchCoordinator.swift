//
//  LaunchCoordinator.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//  Copyright (c) 2024. All rights reserved.
//

import UIKit

class LaunchCoordinator: BaseCoordinator {
    private let router: RouterProtocol
    private let controller: UIViewController
    private let viewModel: LaunchViewModel
    var configurationEnd: EmptyBlock?
    
    init(router: RouterProtocol, container: DIContainer) {
        self.router = router
        viewModel = LaunchViewModel(container: container)
        controller = LaunchView(viewModel: self.viewModel).makeViewController()
        super.init()
    }
    
    func start() {
        configurationEnd = viewModel.configurationEnd
    }
}

extension LaunchCoordinator: Drawable {
    var viewController: UIViewController? { return controller }
}
