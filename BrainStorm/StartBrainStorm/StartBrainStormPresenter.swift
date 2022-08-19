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
    func openEnterPlayerName(count: Int) {
        router.openEnterPlayerName(count: count)
    }
    
    func startBrainStorm(name: String) {
        moduleOutput?.addCard(savedCard: SavedCard(brainStormName: name,
                                                   brainStormDescription: " ",
                                                   brainStormDate: getDateString()))
        
    }
    
    func viewDidLoad() {
        
    }
    
    
    func getDateString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from:  date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        return "\(day).\(month).\(year)"
    }
    
}

extension StartBrainStormPresenter: StartBrainStormInteractorOutput {
}

