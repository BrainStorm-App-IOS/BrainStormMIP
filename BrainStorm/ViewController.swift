//
//  ViewController.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//

import UIKit
import PinLayout

//class ViewController: UIViewController, UINavigationControllerDelegate {
//    private let productsButton = UIButton()
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setup()
//    }
//
//    private func setup() {
//        view.addSubview(productsButton)
//        productsButton.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
//        productsButton.layer.cornerRadius = 8
//        productsButton.backgroundColor = .magenta
//        productsButton.setTitle("Мои карты", for: .normal)
//        productsButton.addTarget(self, action: #selector(didTapProductsButton), for: .touchUpInside)
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        productsButton.pin
//            .top(300)
//            .horizontally(32)
//            .height(40)
//    }
//
//    @objc
//    private func didTapProductsButton() {
//        // MARK: VIPER
//        let context = SavedCardContext(moduleOutput: self)
//        let container = SavedCardContainer.assemble(with: context)
//
//        let navigationController = UINavigationController(rootViewController: container.viewController)
//        present(navigationController, animated: true)
//    }
//}
//
//
//
//
//
//
//extension ViewController: SavedCardModuleOutput {
//    func productCollectionModuleWillClose() {
//
//    }
//}


class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Юла Сириус"
        
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
