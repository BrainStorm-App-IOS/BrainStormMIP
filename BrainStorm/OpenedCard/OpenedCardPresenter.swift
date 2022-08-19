//
//  OpenedCardPresenter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/15/22.
//  
//

import Foundation

final class OpenedCardPresenter {
    weak var view: OpenedCardViewInput?
    weak var moduleOutput: OpenedCardModuleOutput?
    
    private let router: OpenedCardRouterInput
    private let interactor: OpenedCardInteractorInput
    
    init(router: OpenedCardRouterInput, interactor: OpenedCardInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension OpenedCardPresenter: OpenedCardModuleInput {
}

extension OpenedCardPresenter: OpenedCardViewOutput {
}

extension OpenedCardPresenter: OpenedCardInteractorOutput {
}
