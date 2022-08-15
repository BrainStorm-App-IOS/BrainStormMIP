//
//  StartBrainStormPresenter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//  
//

import Foundation

final class StartBrainStormPresenter {
    weak var view: StartBrainStormViewInput?
    weak var moduleOutput: StartBrainStormModuleOutput?
    
    private let router: StartBrainStormRouterInput
    private let interactor: StartBrainStormInteractorInput
    
    init(router: StartBrainStormRouterInput, interactor: StartBrainStormInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension StartBrainStormPresenter: StartBrainStormModuleInput {
}

extension StartBrainStormPresenter: StartBrainStormViewOutput {
    func send(name: String, description: String) {
        moduleOutput?.addCard(savedCard: SavedCard(brainStormName: name, brainStormDescription: description))
        router.dismiss()
        
    }
    
    func viewDidLoad() {
        
    }
    
    func dismiss() {
        router.dismiss()
    }
    
}

extension StartBrainStormPresenter: StartBrainStormInteractorOutput {
}
