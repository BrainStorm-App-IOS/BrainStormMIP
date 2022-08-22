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
    func openNextField() {
        let TeammateCardSolutionContext = TeammateCardSolutionContext(moduleOutput: self, cards: [("aalje","a;len"),
                                                                                                  ("aalje","a;len"),
                                                                                                  ("aalje","a;len"),
                                                                                                  ("aalje","a;len"),
                                                                                                  ("aalje","a;len")])
        let TeammateCardSolutionContainer = TeammateCardSolutionContainer.assemble(with: TeammateCardSolutionContext)
        
        MainNavigationController.navigationController.pushViewController(TeammateCardSolutionContainer.viewController, animated: true)
    }
}

extension DiscussionRouter: TeammateCardSolutionModuleOutput {
    
}
