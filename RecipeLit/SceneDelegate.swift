//
//  SceneDelegate.swift
//  RecipeLit
//
//  Created by JeonSangHyeok on 12/26/23.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    let mainNavigationController = UINavigationController()
    let searchNavigationController = UINavigationController()
    let myPageNavigationController = UINavigationController()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        window?.makeKeyAndVisible()
        window?.rootViewController = configureTabBarController()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }


}

private extension SceneDelegate {
    func configureNavigationControllers() {
        mainNavigationController.viewControllers = [configureMainController()]
        searchNavigationController.viewControllers = [configureSearchController()]
        myPageNavigationController.viewControllers = [MyPageViewController()]
    }
    
    func configureTabBarController() -> CustomTabBarController {
        configureNavigationControllers()
        let tabBarCotrnoller = CustomTabBarController(controllers: [mainNavigationController, searchNavigationController, myPageNavigationController])
        return tabBarCotrnoller
    }
    
    func configureMainController() -> MainViewController {
        let mainViewController = MainViewController()
        mainViewController.collectionCellTapped = { [unowned self] in
            let detailViewController = configureDetailController()
            mainViewController.navigationController?.pushViewController(detailViewController, animated: true)
        }
        return mainViewController
    }
    
    func configureSearchController() -> SearchViewController {
        let searchViewController = SearchViewController()
        return searchViewController
    }
    
    func configureDetailController() -> DetailViewController {
        let detailViewController = DetailViewController()
        detailViewController.hidesBottomBarWhenPushed = true
        return detailViewController
    }
}
