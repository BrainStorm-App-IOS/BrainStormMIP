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
        let SavedCardContext = SavedCardContext(moduleOutput: self)
        let SavedCardContainer = SavedCardContainer.assemble(with: SavedCardContext)
        let SavedCardNavigationController = UINavigationController(rootViewController: SavedCardContainer.viewController)
        
        SavedCardNavigationController.tabBarItem.image = UIImage(systemName: "house")
        profileSettings.tabBarItem.image = UIImage(systemName: "magnifyingglass")
        
        setViewControllers([SavedCardNavigationController, profileSettings], animated: true)
    }
}


extension TabBarController: SavedCardModuleOutput {
}
