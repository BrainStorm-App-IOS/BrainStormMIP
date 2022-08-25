//
//  StartBrainStormInteractor.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//  
//

import Foundation

final class StartBrainStormInteractor {
    weak var output: StartBrainStormInteractorOutput?
}

extension StartBrainStormInteractor: StartBrainStormInteractorInput {
    
    func saveGame(game: GameModel) {
        GameNetwork.createGameOnFirebase(game: game)
    }
}
