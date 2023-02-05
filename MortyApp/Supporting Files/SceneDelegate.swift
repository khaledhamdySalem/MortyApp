//
//  SceneDelegate.swift
//  MortyApp
//
//  Created by KH on 05/02/2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window
        
        let vc = RMTabBarController()
        window.rootViewController = vc
        window.makeKeyAndVisible()
        
    }
}

