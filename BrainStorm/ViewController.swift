//
//  ViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//

import UIKit
import PinLayout
import SwiftUI

struct MainNavigationController {
    static var navigationController: UINavigationController = UINavigationController()
}

class TabBarController: UITabBarController, ProfileModuleOutput {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let SavedCardContext = SavedCardContext(moduleOutput: self)
        let SavedCardContainer = SavedCardContainer.assemble(with: SavedCardContext)
        MainNavigationController.navigationController = UINavigationController(rootViewController: SavedCardContainer.viewController)
        
        
        let ProfileContext = ProfileContext(moduleOutput: self)
        let ProfileContainer = ProfileContainer.assemble(with: ProfileContext)
        let ProfileNavigationController = UINavigationController(rootViewController: ProfileContainer.viewController)
        MainNavigationController.navigationController.navigationBar.prefersLargeTitles = true
        //SavedCardNavigationController.navigationBar.isHidden = true
        ProfileNavigationController.navigationBar.prefersLargeTitles = true
        
        MainNavigationController.navigationController.tabBarItem.image = UIImage(systemName: "brain")
        ProfileContainer.viewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        setViewControllers([MainNavigationController.navigationController,ProfileNavigationController], animated: true)
        tabBar.tintColor = .blue | .yellow
        
        tabBar.unselectedItemTintColor = .black | .white
    }
}


extension TabBarController: SavedCardModuleOutput {
}
