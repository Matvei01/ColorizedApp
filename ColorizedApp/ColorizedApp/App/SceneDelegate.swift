//
//  SceneDelegate.swift
//  ColorizedApp
//
//  Created by Matvei Khlestov on 28.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let viewController = UINavigationController(rootViewController: MainViewController())
        window.rootViewController = viewController
        self.window = window
        window.makeKeyAndVisible()
    }
}

