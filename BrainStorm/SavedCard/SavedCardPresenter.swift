//
//  SavedCardPresenter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//  
//

import Foundation

final class SavedCardPresenter {
    weak var view: SavedCardViewInput?
    weak var moduleOutput: SavedCardModuleOutput?
    
    private let router: SavedCardRouterInput
    private let interactor: SavedCardInteractorInput
    
    private var savedCards: [SavedCard] = [SavedCard(brainStormName: "hello", brainStormDescription: "none"),
                                           SavedCard(brainStormName: "jalejf", brainStormDescription: "sjepoeipjf"),
                                           SavedCard(brainStormName: "394", brainStormDescription: "9384")]
    
    init(router: SavedCardRouterInput, interactor: SavedCardInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SavedCardPresenter: SavedCardModuleInput {
}

extension SavedCardPresenter: SavedCardViewOutput {
    
    func openBrainStromSettings() {
        router.openBrainStormSettings(output: self)
    }
    
    func getCount() -> Int {
        return savedCards.count
    }
    
    func getItem(in index: Int) -> SavedCard {
        return savedCards[index]
    }
    
    func viewDidLoad() {
    }
    
}

extension SavedCardPresenter: SavedCardInteractorOutput {
}

extension SavedCardPresenter: StartBrainStormModuleOutput{
    func addCard(savedCard: SavedCard) {
        savedCards.append(savedCard)
        view?.reloadData()
    }
    
    
    
}
