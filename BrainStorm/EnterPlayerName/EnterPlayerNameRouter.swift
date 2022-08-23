//
//  EnterPlayerNameRouter.swift
//  BrainStorm
//
//  Created by Кирилл Санников on 18.08.2022.
//  
//

import UIKit

final class EnterPlayerNameRouter {
    weak var viewController: UIViewController?
}

extension EnterPlayerNameRouter: EnterPlayerNameRouterInput {
    func openPlayerProblems(game: GameModel) {
        let PlayerProblemsContext = PlayerProblemsContext(moduleOutput: self, game: game)
        let PlayerProblemsContainer = PlayerProblemsContainer.assemble(with: PlayerProblemsContext)
        
        MainNavigationController.navigationController.pushViewController(PlayerProblemsContainer.viewController, animated: true)
        
    }
    
    func nextDisplay(cntPlayer: Int, presenter: EnterPlayerNameViewOutput) -> EnterPlayerNameViewInput {
        let view = EnterPlayerNameViewController(output: presenter, currPlayer: cntPlayer)
        MainNavigationController.navigationController.pushViewController(view, animated: true)
        return view
    }
    
}

extension EnterPlayerNameRouter: PlayerProblemsModuleOutput {
    
}
