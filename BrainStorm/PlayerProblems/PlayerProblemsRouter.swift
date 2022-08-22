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
    func openNextScreen() {
        let DiscussionContext = DiscussionContext(moduleOutput: self, teamName: "Team", theme: "Math", countOfPlayers: 6)
        let DiscussionContainer = DiscussionContainer.assemble(with: DiscussionContext)
        
        MainNavigationController.navigationController.pushViewController(DiscussionContainer.viewController, animated: true)
    }
    
}

extension PlayerProblemsRouter: DiscussionModuleOutput {
    
}
