//
//  ModalRouter.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import UIKit

typealias ModalCloseClosure = (() -> Void)

protocol RouterModalProtocol: AnyObject {
    func present(_ drawable: Drawable, isAnimated: Bool, onClose closure: ModalCloseClosure?)
    func presentSheet(_ drawable: Drawable, isAnimated: Bool, detents: [UISheetPresentationController.Detent], onClose closure: ModalCloseClosure?)
    func dismiss(_ drawable: Drawable, isAnimated: Bool)
    func dismiss(_ drawable: Drawable, isAnimated: Bool, onClose closure: ModalCloseClosure?)

    /// To prevent memory leak, use this metod only with inited previousModalRouter
    func dismissToRoot(isAnimated: Bool)
}

class RouterModal: NSObject, RouterModalProtocol {
    private weak var previousModalRouter: RouterModalProtocol?
    private weak var rootController: UIViewController?
    private var closure: ModalCloseClosure?

    init(root drawable: Drawable, previousModalRouter: RouterModalProtocol? = nil) {
        self.rootController = drawable.viewController
        self.previousModalRouter = previousModalRouter
        super.init()
    }

    deinit {
        debugPrint("DEINITED \(String(describing: self))")
    }

    func present(_ drawable: Drawable, isAnimated: Bool, onClose closure: ModalCloseClosure?) {
        guard let viewController = drawable.viewController else { return }
        viewController.presentationController?.delegate = self
        self.closure = closure

        rootController?.present(viewController, animated: isAnimated, completion: nil)
    }
    
    func presentSheet(_ drawable: Drawable, isAnimated: Bool, detents: [UISheetPresentationController.Detent] = [.medium()], onClose closure: ModalCloseClosure?) {
        guard let viewController = drawable.viewController else { return }
        viewController.presentationController?.delegate = self
        viewController.modalPresentationStyle = .pageSheet
        self.closure = closure
        
        if let sheet = viewController.sheetPresentationController {
            sheet.detents = detents
            sheet.prefersGrabberVisible = true
        }
 
        rootController?.present(viewController, animated: true, completion: nil)
    }
    
    func dismiss(_ drawable: Drawable, isAnimated: Bool) {
        guard let viewController = drawable.viewController else { return }

        viewController.dismiss(animated: isAnimated) { [weak self] in
            self?.closure?()
        }
    }

    func dismiss(_ drawable: Drawable, isAnimated: Bool, onClose closure: ModalCloseClosure?) {
        guard let viewController = drawable.viewController else { return }

        viewController.dismiss(animated: isAnimated) { [weak self] in
            closure?()
            self?.closure?()
        }
    }

    func dismissToRoot(isAnimated: Bool) {
        UIWindow.main?.rootViewController?.dismiss(animated: isAnimated) { [weak self] in
            self?.previousModalRouter?.dismissToRoot(isAnimated: false)
            self?.closure?()
        }
    }
}

extension RouterModal: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        closure?()
    }
}
