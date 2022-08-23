//
//  PlayerProblemsRouter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//  
//

import UIKit

final class PlayerProblemsRouter {
}

extension PlayerProblemsRouter: PlayerProblemsRouterInput {
    func openDiscussion(game: GameModel) {
        let DiscussionContext = DiscussionContext(moduleOutput: self, game: game)
        let DiscussionContainer = DiscussionContainer.assemble(with: DiscussionContext)
        
        MainNavigationController.navigationController.pushViewController(DiscussionContainer.viewController, animated: true)
    }
    
    func openNextScreen() {
//        let DiscussionContext = DiscussionContext(moduleOutput: self, teamName: "Team", theme: "Math", countOfPlayers: 6)
//        let DiscussionContainer = DiscussionContainer.assemble(with: DiscussionContext)
//        
//        MainNavigationController.navigationController.pushViewController(DiscussionContainer.viewController, animated: true)
    }
    
    func nextDisplay(presenter: PlayerProblemsViewOutput) -> PlayerProblemsViewInput {
        let view = PlayerProblemsViewController(output: presenter)
        MainNavigationController.navigationController.pushViewController(view, animated: true)
        return view
    }
    
}

extension PlayerProblemsRouter: DiscussionModuleOutput {
    
}
