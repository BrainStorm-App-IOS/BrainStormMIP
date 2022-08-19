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

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let profileSettings = ProfileSettingsViewController()
        profileSettings.title = "Profile"
        
        let SavedCardContext = SavedCardContext(moduleOutput: self)
        let SavedCardContainer = SavedCardContainer.assemble(with: SavedCardContext)
        let SavedCardNavigationController = UINavigationController(rootViewController: SavedCardContainer.viewController)
        
        MainNavigationController.navigationController = SavedCardNavigationController
        //SavedCardNavigationController.navigationBar.prefersLargeTitles = true
        SavedCardNavigationController.navigationBar.isHidden = true
        
        SavedCardNavigationController.tabBarItem.image = UIImage(systemName: "brain")
        profileSettings.tabBarItem.image = UIImage(systemName: "person.crop.circle")
        
        setViewControllers([SavedCardNavigationController, profileSettings], animated: true)
        tabBar.tintColor = Color.tapBarTincColor
        
        tabBar.unselectedItemTintColor = Color.defaultBlackAndWhiteColor
    }
}


extension TabBarController: SavedCardModuleOutput {
}
