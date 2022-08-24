//
//  EnterPlayerNamePresenter.swift
//  BrainStorm
//
//  Created by Кирилл Санников on 18.08.2022.
//  
//

import Foundation

final class EnterPlayerNamePresenter {
    // from ViewController
    weak var view: EnterPlayerNameViewInput?
    // Presenter from another module
    weak var moduleOutput: EnterPlayerNameModuleOutput?
    
    // in Router
    private let router: EnterPlayerNameRouterInput
    // in Interactor
    private let interactor: EnterPlayerNameInteractorInput
    private let sizeOfStackAtStart: Int
    private var currPlayer = 1
    
    private var game: GameModel
    
    init(router: EnterPlayerNameRouterInput, interactor: EnterPlayerNameInteractorInput, game: GameModel) {
        self.router = router
        self.interactor = interactor
        self.game = game
        sizeOfStackAtStart = MainNavigationController.navigationController.viewControllers.count
    }
    
}

extension EnterPlayerNamePresenter: EnterPlayerNameModuleInput {
}

extension EnterPlayerNamePresenter: EnterPlayerNameViewOutput {
    func addPerson(name: String) {
        game.persons.append(PersonModel(name: name))
    }
    
    func nextPlayer() {
        currPlayer = MainNavigationController.navigationController.viewControllers.count - sizeOfStackAtStart
        if (currPlayer == game.countOfPersons) {
//            MainNavigationController.navigationController.viewControllers = MainNavigationController.navigationController.viewControllers.dropLast(currPlayer)
//            print("all players")
            router.openPlayerProblems(game: game)
        } else {
            currPlayer += 1
            view = router.nextDisplay(cntPlayer: currPlayer, presenter: self)
        }
    }
}

extension EnterPlayerNamePresenter: EnterPlayerNameInteractorOutput {
}
