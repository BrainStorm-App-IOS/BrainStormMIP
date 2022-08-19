//
//  ViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//

import UIKit
import PinLayout

class TabBarController: UITabBarController, ProfileModuleOutput {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        //let profileSettings = ProfileSettingsViewController()
        
        //profileSettings.title = "Profile"
        let SavedCardContext = SavedCardContext(moduleOutput: self)
        let SavedCardContainer = SavedCardContainer.assemble(with: SavedCardContext)
        let SavedCardNavigationController = UINavigationController(rootViewController: SavedCardContainer.viewController)
        
        
        let ProfileContext = ProfileContext(moduleOutput: self)
        let ProfileContainer = ProfileContainer.assemble(with: ProfileContext)
        let ProfileNavigationController = UINavigationController(rootViewController: ProfileContainer.viewController)
        SavedCardNavigationController.navigationBar.prefersLargeTitles = true
        //SavedCardNavigationController.navigationBar.isHidden = true
        ProfileNavigationController.navigationBar.prefersLargeTitles = true
        
        SavedCardNavigationController.tabBarItem.image = UIImage(systemName: "brain")
        ProfileContainer.viewController.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        setViewControllers([SavedCardNavigationController,ProfileNavigationController], animated: true)
        tabBar.tintColor = .blue | .yellow
        
        tabBar.unselectedItemTintColor = .black | .white
    }
}


extension TabBarController: SavedCardModuleOutput {
}
