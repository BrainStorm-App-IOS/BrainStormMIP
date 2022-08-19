//
//  SavedCardRouter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//  
//

import UIKit

final class SavedCardRouter {
    weak var viewController: UIViewController?
}

extension SavedCardRouter: SavedCardRouterInput {
    func openCard(output: OpenedCardModuleOutput, savedCard: SavedCard) {
        let context = OpenedCardContext(moduleOutput: output, savedCard: savedCard)
        let container = OpenedCardContainer.assemble(with: context)
        
        
        let navigationController = UINavigationController(rootViewController: container.viewController)
        
        viewController?.present(navigationController, animated: true)
    }
    
    func openBrainStormSettings(output: StartBrainStormModuleOutput){
        let startBrainStormContext = StartBrainStormContext(moduleOutput: output)
        let startBrainStormContainer = StartBrainStormContainer.assemble(with: startBrainStormContext)
        
        startBrainStormContainer.viewController.hidesBottomBarWhenPushed = true
        MainNavigationController.navigationController.navigationBar.isHidden = false
        MainNavigationController.navigationController.pushViewController(startBrainStormContainer.viewController, animated: true)
                
    }
}
