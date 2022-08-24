//
//  SavedCardProtocols.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//  
//

import Foundation

protocol SavedCardModuleInput {
    var moduleOutput: SavedCardModuleOutput? { get }
}

protocol SavedCardModuleOutput: AnyObject {
}

protocol SavedCardViewInput: AnyObject {
    func reloadData()
}

protocol SavedCardViewOutput: AnyObject {
    
    func continueGame(at index: Int)
    
    func viewDidLoad()
    
    func getItem(in index: Int) -> GameModel
    
    func getCount() -> Int
    
    func openBrainStromSettings()
    
    func didTapCard(savedCard: GameModel)
}

protocol SavedCardInteractorInput: AnyObject {
    func getAllGames()
    
    func updateGamesonFirebase(game: GameModel)
    
    func saveGame(game: GameModel)
}

protocol SavedCardInteractorOutput: AnyObject {
    func didObtain(games: [GameModel])
    
    func didFail(with error: Error)
    
    func updateGamesonFirebase(game: GameModel)
    
    func saveGame(game: GameModel)
    
}

protocol SavedCardRouterInput: AnyObject {
    func openBrainStormSettings(output: StartBrainStormModuleOutput)
    
    func openCard(output: OpenedCardModuleOutput, savedCard: GameModel)
}
