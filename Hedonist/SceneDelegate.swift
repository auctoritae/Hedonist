//
//  SceneDelegate.swift
//  Hedonist
//
//  Created by a.lobanov on 12/21/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Variable
    var window: UIWindow?
    
    private lazy var tabController = UITabBarController()
    private lazy var mainVC = MainBuilder.build()
    private lazy var favsVC = FavsBuilder.build()
    private lazy var mapVC = MapBuilder.build()
    
    
    // MARK: - System implementation
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }
    
    func sceneDidDisconnect(_ scene: UIScene) { }
    func sceneDidBecomeActive(_ scene: UIScene) { }
    func sceneWillResignActive(_ scene: UIScene) { }
    func sceneWillEnterForeground(_ scene: UIScene) { }
    func sceneDidEnterBackground(_ scene: UIScene) { }
    
    
    // MARK: - Private implementation
    private func createTabBarController() -> UITabBarController {
        mainVC.tabBarItem = UITabBarItem(title: Titles.mainTabTitle, image: UIImage(systemName: "antenna.radiowaves.left.and.right.circle.fill"), tag: 0)
        favsVC.tabBarItem = UITabBarItem(title: Titles.favSceneTitle, image: UIImage(systemName: "heart.circle.fill"), tag: 1)
        mapVC.tabBarItem = UITabBarItem(title: Titles.mapSceneTitle, image: UIImage(systemName: "map.circle.fill"), tag: 2)
        
        tabController.viewControllers = [mainVC, favsVC, mapVC]
        UITabBar.appearance().backgroundColor = .systemBackground
        return tabController
    }
}

