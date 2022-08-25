//
//  PlayerProblemsContainer.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//  
//

import UIKit

final class PlayerProblemsContainer {
    let input: PlayerProblemsModuleInput
    let viewController: UIViewController
    private(set) weak var router: PlayerProblemsRouterInput!
    
    class func assemble(with context: PlayerProblemsContext) -> PlayerProblemsContainer {
        let router = PlayerProblemsRouter()
        let interactor = PlayerProblemsInteractor()
        var presenter = PlayerProblemsPresenter(router: router, interactor: interactor, game: context.game)
        if let player = context.currPlayer {
            presenter = PlayerProblemsPresenter(router: router, interactor: interactor, game: context.game, currPlayer: player)
        }
        let viewController = PlayerProblemsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return PlayerProblemsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: PlayerProblemsModuleInput, router: PlayerProblemsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct PlayerProblemsContext {
    weak var moduleOutput: PlayerProblemsModuleOutput?
    var game: GameModel
    var currPlayer: Int?
}
