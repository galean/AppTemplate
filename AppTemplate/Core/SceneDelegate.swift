//
//  SceneDelegate.swift
//  AppTemplate
//
//  Created by Mavic on 09.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    var appCoordinator: AppCoordinator?

    lazy var appEnvironment: AppEnvironment? = {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        return appDelegate?.appEnvironment
    }()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene), let container = appEnvironment?.container else { return }
        startCoordinator(windowScene: windowScene, container: container)
    }
    
    private func startCoordinator(windowScene: UIWindowScene, container: DIContainer) {
        let window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window.windowScene = windowScene
        let appCoordinator = AppCoordinator(window: window, container: container)
        appCoordinator.start()
        
        self.appCoordinator = appCoordinator
        self.window = window
    }
}
