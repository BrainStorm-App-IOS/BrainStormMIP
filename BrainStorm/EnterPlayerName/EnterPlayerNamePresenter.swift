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
    private let count: Int
    private let sizeOfStackAtStart: Int
    private var currPlayer = 1
    
    init(router: EnterPlayerNameRouterInput, interactor: EnterPlayerNameInteractorInput, count: Int) {
        self.router = router
        self.interactor = interactor
        self.count = count
        sizeOfStackAtStart = MainNavigationController.navigationController.viewControllers.count
    }
    
}

extension EnterPlayerNamePresenter: EnterPlayerNameModuleInput {
}

extension EnterPlayerNamePresenter: EnterPlayerNameViewOutput {
    func nextPlayer(name: String) {
        currPlayer = MainNavigationController.navigationController.viewControllers.count - sizeOfStackAtStart
        print("Current player: \(currPlayer) name is \(name)")
        if (currPlayer == count) {
            MainNavigationController.navigationController.viewControllers = MainNavigationController.navigationController.viewControllers.dropLast(currPlayer)
            print("all players")
        } else {
            print("start stack size: \(sizeOfStackAtStart)")
            print("stack size: \(MainNavigationController.navigationController.viewControllers.count)")
            currPlayer += 1
            view = router.nextDisplay(cntPlayer: currPlayer, presenter: self)
        }
    }
}

extension EnterPlayerNamePresenter: EnterPlayerNameInteractorOutput {
}
