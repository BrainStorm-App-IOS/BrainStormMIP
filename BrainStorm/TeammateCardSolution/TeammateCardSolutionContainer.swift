//
//  TeammateCardSolutionContainer.swift
//  test
//
//  Created by Кирилл Санников on 22.08.2022.
//  
//

import UIKit

final class TeammateCardSolutionContainer {
    let input: TeammateCardSolutionModuleInput
    let viewController: UIViewController
    private(set) weak var router: TeammateCardSolutionRouterInput!
    
    class func assemble(with context: TeammateCardSolutionContext) -> TeammateCardSolutionContainer {
        let router = TeammateCardSolutionRouter()
        let interactor = TeammateCardSolutionInteractor()
        var presenter = TeammateCardSolutionPresenter(router: router, interactor: interactor, game: context.game)
        if let index = context.currInd {
            presenter = TeammateCardSolutionPresenter(router: router, interactor: interactor, game: context.game, currCardInd: index)
        }
        let viewController = TeammateCardSolutionViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return TeammateCardSolutionContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: TeammateCardSolutionModuleInput, router: TeammateCardSolutionRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct TeammateCardSolutionContext {
    weak var moduleOutput: TeammateCardSolutionModuleOutput?
    var game: GameModel
    var currInd: Int?
}
