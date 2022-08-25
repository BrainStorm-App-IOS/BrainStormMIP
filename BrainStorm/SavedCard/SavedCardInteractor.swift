//
//  SavedCardInteractor.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//  
//

import Foundation

final class SavedCardInteractor {
    weak var output: SavedCardInteractorOutput?
}

extension SavedCardInteractor: SavedCardInteractorInput {
    func getAllGames() {
        GameNetwork.fetchAllGameOfCurrentUser { [weak output] result in
            switch result {
            case .success(let games):
                output?.didObtain(games: games)
            case .failure(let error):
                output?.didFail(with: error)
            }
        }
    }
    
    func updateGamesonFirebase(game: GameModel) {
        GameNetwork.refreshGameOnFirebase(game: game)
    }
    
    func saveGame(game: GameModel) {
        GameNetwork.createGameOnFirebase(game: game)
    }
    
}

