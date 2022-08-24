//
//  TeammateCardSolutionRouter.swift
//  test
//
//  Created by Кирилл Санников on 22.08.2022.
//  
//

import UIKit

final class TeammateCardSolutionRouter {
}

extension TeammateCardSolutionRouter: TeammateCardSolutionRouterInput {
    func openNextScreen(game: GameModel) {
        MainNavigationController.navigationController.pushViewController(SliderViewController(game: game, counter: game.results.count), animated: true)
    }
    
}
