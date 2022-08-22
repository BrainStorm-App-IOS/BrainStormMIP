//
//  TeammateCardSolutionPresenter.swift
//  test
//
//  Created by Кирилл Санников on 22.08.2022.
//  
//

import Foundation

final class TeammateCardSolutionPresenter {
    weak var view: TeammateCardSolutionViewInput?
    weak var moduleOutput: TeammateCardSolutionModuleOutput?
    
    private let router: TeammateCardSolutionRouterInput
    private let interactor: TeammateCardSolutionInteractorInput
    
    let cards: [(String, String)]
    var resultCards = [(String, String, String)]()
    var currCardInd = 0
    
    init(router: TeammateCardSolutionRouterInput,
         interactor: TeammateCardSolutionInteractorInput,
         cards: [(String, String)]) {
        self.router = router
        self.interactor = interactor
        self.cards = cards
    }
}

extension TeammateCardSolutionPresenter: TeammateCardSolutionModuleInput {
}

extension TeammateCardSolutionPresenter: TeammateCardSolutionViewOutput {
    func openNextScreen(solution: String) {
        let resultCard = (cards[currCardInd - 1].0, cards[currCardInd - 1].1, solution)
        print(resultCard)
        resultCards.append(resultCard)
        if currCardInd == cards.count {
            // go to next Display
            MainNavigationController.navigationController.viewControllers = MainNavigationController.navigationController.viewControllers.dropLast(1)
            router.openNextScreen(cards: resultCards)
        } else {
            let viewTmp = TeammateCardSolutionViewController(output: self, card: createViewInfo())
            view = viewTmp
            MainNavigationController.navigationController.viewControllers = MainNavigationController.navigationController.viewControllers.dropLast(1)
            viewTmp.addBlur()
            MainNavigationController.navigationController.pushViewController(viewTmp, animated: false)
            viewTmp.deleteBlur()
        }
    }
}

extension TeammateCardSolutionPresenter: TeammateCardSolutionInteractorOutput {
    func createViewInfo() -> (String, String) {
        let result = cards[currCardInd]
        currCardInd += 1
        return result
    }
}
