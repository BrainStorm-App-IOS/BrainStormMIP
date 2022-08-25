//
//  StartBrainStormProtocols.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//  
//

import Foundation

protocol StartBrainStormModuleInput {
    var moduleOutput: StartBrainStormModuleOutput? { get }
}

protocol StartBrainStormModuleOutput: AnyObject {
    
    func addCard(savedCard: GameModel)
}

protocol StartBrainStormViewInput: AnyObject {
}

protocol StartBrainStormViewOutput: AnyObject {
    func viewDidLoad()
    
    func openEnterPlayerName()
    
    func getDateString() -> String
    
    func setTheme(theme: String)
    
    func setCountOfPlayers(countOfPlayers: Int)
    
    func setTeamName(teamName: String) 
}

protocol StartBrainStormInteractorInput: AnyObject {
    func saveGame(game: GameModel)
}

protocol StartBrainStormInteractorOutput: AnyObject {
}

protocol StartBrainStormRouterInput: AnyObject {
    func openEnterPlayerName(game: GameModel)
}
