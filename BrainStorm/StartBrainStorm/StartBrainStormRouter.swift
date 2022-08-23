//
//  StartBrainStormRouter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//  
//

import UIKit

final class StartBrainStormRouter: EnterPlayerNameModuleOutput {
    weak var viewController: UIViewController?
}

extension StartBrainStormRouter: StartBrainStormRouterInput {
    func openEnterPlayerName(game: GameModel) {
        let EnterPlayerNameContext = EnterPlayerNameContext(moduleOutput: self, game: game)
        let EnterPlayerNameContainer = EnterPlayerNameContainer.assemble(with: EnterPlayerNameContext)
        
        MainNavigationController.navigationController.pushViewController(EnterPlayerNameContainer.viewController, animated: true)
        
    }
}
