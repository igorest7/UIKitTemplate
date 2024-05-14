//
//  SceneDelegate.swift
//  UIKitTemplate
//
//  Created by Igor Nakonetsnoi on 02/04/2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    private lazy var viewModelFactory: ViewModelFactory = ConcreteViewModelFactory(appDependencyProvider: AppDependencyProvider())
    private lazy var coordinator: AppCoordinator = AppCoordinator(viewModelFactory: viewModelFactory)

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let window = UIWindow(windowScene: windowScene)


        coordinator.setup(for: window)
        self.window = window 

        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}

}

