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
    
    private var game: GameModel
    private var currCardInd: Int = 1
    
    init(router: TeammateCardSolutionRouterInput,
         interactor: TeammateCardSolutionInteractorInput,
         game: GameModel) {
        self.router = router
        self.interactor = interactor
        self.game = game
    }
}

extension TeammateCardSolutionPresenter: TeammateCardSolutionModuleInput {
}

extension TeammateCardSolutionPresenter: TeammateCardSolutionViewOutput {
    func getPersonName() -> String {
        print(game.persons[currCardInd - 1].name)
        return game.persons[currCardInd - 1].name
    }
    
    func getProblem() -> String {
        return game.results[currCardInd - 1].problem
    }
    
    func openNextScreen(solution: String) {
//        let resultCard = (cards[currCardInd - 1].0, cards[currCardInd - 1].1, solution)
//        print(resultCard)
//        resultCards.append(resultCard)
        game.results[currCardInd - 1].solution = solution
        if currCardInd == game.countOfPlayers {
            // go to next Display
            MainNavigationController.navigationController.viewControllers = MainNavigationController.navigationController.viewControllers.dropLast(1)
            router.openNextScreen(game: game)
        } else {
            currCardInd += 1
            let viewTmp = TeammateCardSolutionViewController(output: self)
            view = viewTmp
            MainNavigationController.navigationController.viewControllers = MainNavigationController.navigationController.viewControllers.dropLast(1)
            viewTmp.addBlur()
            MainNavigationController.navigationController.pushViewController(viewTmp, animated: false)
            viewTmp.deleteBlur()
        }
    }
}

extension TeammateCardSolutionPresenter: TeammateCardSolutionInteractorOutput {
//    func createViewInfo() -> (String, String) {
//        let result = cards[currCardInd]
//        currCardInd += 1
//        return result
//    }
}
