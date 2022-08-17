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

        
        let profileSettings = ProfileSettingsViewController()
        
        profileSettings.title = "Profile"
        let SavedCardContext = SavedCardContext(moduleOutput: self)
        let SavedCardContainer = SavedCardContainer.assemble(with: SavedCardContext)
        let SavedCardNavigationController = UINavigationController(rootViewController: SavedCardContainer.viewController)
        //SavedCardNavigationController.navigationBar.prefersLargeTitles = true
        SavedCardNavigationController.navigationBar.isHidden = true
        
        SavedCardNavigationController.tabBarItem.image = UIImage(systemName: "brain")
        profileSettings.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        setViewControllers([SavedCardNavigationController, profileSettings], animated: true)
        tabBar.tintColor = .blue | .yellow
        
        tabBar.unselectedItemTintColor = .black | .white
    }
}


extension TabBarController: SavedCardModuleOutput {
}
