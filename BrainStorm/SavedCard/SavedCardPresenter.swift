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
    
    private var savedCards: [SavedCard] = [SavedCard(brainStormName: "VK", brainStormDescription: "SDK", brainStormDate: "12.12.12"),
                                           SavedCard(brainStormName: "Yandex", brainStormDescription: "Go", brainStormDate: "11.11.11"),
                                           SavedCard(brainStormName: "Google", brainStormDescription: "Mobile", brainStormDate: "10.10.10")]
    
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
    
    func didTapCard(savedCard: SavedCard){
        router.openCard(output: self, savedCard: savedCard)
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


extension SavedCardPresenter: OpenedCardModuleOutput{
    
}
