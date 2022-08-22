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
    func openNextScreen(cards: [(String, String, String)]) {
        
        let names = ["Кирилл", "Олег", "Паша"]
        
        MainNavigationController.navigationController.pushViewController(SliderViewController(cardsData: cards, names: names), animated: true)
    }
    
}
