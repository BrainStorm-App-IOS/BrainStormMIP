//
//  DiscussionProtocols.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 20.08.2022.
//
//

import Foundation

protocol DiscussionModuleInput {
    var moduleOutput: DiscussionModuleOutput? { get }
}

protocol DiscussionModuleOutput: AnyObject {
}

protocol DiscussionViewInput: AnyObject {
}

protocol DiscussionViewOutput: AnyObject {
    func openNextField()
    
    func getTeamName() -> String
    
    func getProblems() -> [String]
    
    func getTheme() -> String
    
    func getCountOfProblems() -> Int
    
    func addProblem(problem: String)
    
    func saveGame()
}

protocol DiscussionInteractorInput: AnyObject {
    func updateGamesonFirebase(game: GameModel)
}

protocol DiscussionInteractorOutput: AnyObject {
}

protocol DiscussionRouterInput: AnyObject {
    func openNextField(game: GameModel)
}
