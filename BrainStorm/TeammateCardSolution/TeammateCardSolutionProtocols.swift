//
//  TeammateCardSolutionProtocols.swift
//  test
//
//  Created by Кирилл Санников on 22.08.2022.
//  
//

import Foundation

protocol TeammateCardSolutionModuleInput {
    var moduleOutput: TeammateCardSolutionModuleOutput? { get }
}

protocol TeammateCardSolutionModuleOutput: AnyObject {
}

protocol TeammateCardSolutionViewInput: AnyObject {
}

protocol TeammateCardSolutionViewOutput: AnyObject {
    func openNextScreen(solution: String)
    
    func getPersonName() -> String
    
    func getProblem() -> String
    
    func saveGame()
}

protocol TeammateCardSolutionInteractorInput: AnyObject {
    func updateGamesonFirebase(game: GameModel)
}

protocol TeammateCardSolutionInteractorOutput: AnyObject {
}

protocol TeammateCardSolutionRouterInput: AnyObject {
    func openNextScreen(game: GameModel)
}
