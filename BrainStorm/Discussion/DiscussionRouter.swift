//
//  DiscussionRouter.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 20.08.2022.
//  
//

import UIKit

final class DiscussionRouter {
}

extension DiscussionRouter: DiscussionRouterInput {
    func openNextField(game: GameModel) {
        let TeammateCardSolutionContext = TeammateCardSolutionContext(moduleOutput: self, game: game)
        let TeammateCardSolutionContainer = TeammateCardSolutionContainer.assemble(with: TeammateCardSolutionContext)
        
        MainNavigationController.navigationController.pushViewController(TeammateCardSolutionContainer.viewController, animated: true)
    }
}

extension DiscussionRouter: TeammateCardSolutionModuleOutput {
    
}
