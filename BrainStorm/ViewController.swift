//
//  ViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//

import UIKit
import PinLayout


class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profile = ProfileSettingsViewController()
        profile.title = "Профиль"
        
        let savedCardContext = SavedCardContext(moduleOutput: self)
        let savedCardContainer = SavedCardContainer.assemble(with: savedCardContext)
        let savedCardNavigationController = UINavigationController(rootViewController: savedCardContainer.viewController)
        
        savedCardNavigationController.tabBarItem.image = UIImage(systemName: "house")
        profile.navigationItem.largeTitleDisplayMode = .always
        let profileNavigationController = UINavigationController(rootViewController: profile)
        savedCardNavigationController.navigationBar.prefersLargeTitles = true
        profileNavigationController.navigationBar.prefersLargeTitles = true
        savedCardNavigationController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        profileNavigationController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.circle"), tag: 2)
        
        
        tabBar.tintColor = .black
        setViewControllers([savedCardNavigationController, profileNavigationController], animated: true)
    }
}


extension TabBarController: SavedCardModuleOutput {
}
