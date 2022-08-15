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
    func openBrainStormSettings(output: StartBrainStormModuleOutput){
        let startBrainStormContext = StartBrainStormContext(moduleOutput: output)
        let startBrainStormContainer = StartBrainStormContainer.assemble(with: startBrainStormContext)
        let navigationController = UINavigationController(rootViewController: startBrainStormContainer.viewController)
                
        viewController?.present(navigationController, animated: true)
                
    }
}
