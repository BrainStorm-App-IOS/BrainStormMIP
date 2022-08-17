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
        let navigationController = UINavigationController(rootViewController: startBrainStormContainer.viewController)
                
        viewController?.present(navigationController, animated: true)
                
    }
}
