//
//  PlayerProblemsPresenter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//  
//

import Foundation

final class PlayerProblemsPresenter {
    weak var view: PlayerProblemsViewInput?
    weak var moduleOutput: PlayerProblemsModuleOutput?
    
    private let router: PlayerProblemsRouterInput
    private let interactor: PlayerProblemsInteractorInput
    
    init(router: PlayerProblemsRouterInput, interactor: PlayerProblemsInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension PlayerProblemsPresenter: PlayerProblemsModuleInput {
}

extension PlayerProblemsPresenter: PlayerProblemsViewOutput {
    func openNextScreen() {
    }
    
}

extension PlayerProblemsPresenter: PlayerProblemsInteractorOutput {
}
