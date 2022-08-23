//
//  PlayerProblemsProtocols.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//  
//

import Foundation

protocol PlayerProblemsModuleInput {
    var moduleOutput: PlayerProblemsModuleOutput? { get }
}

protocol PlayerProblemsModuleOutput: AnyObject {
    
}

protocol PlayerProblemsViewInput: AnyObject {
}

protocol PlayerProblemsViewOutput: AnyObject {
    func openNextScreen()
    
    func nextPlayer()
    
    func getCurrPlayer() -> Int
    
    func getName() -> String
    
    func addProblems()
    
    func rewriteProblem(at index: Int, write problem: String)
    
    func getProblem(at index: Int) -> String
    
    func getTheme() -> String
    
    func getCountofProblems() -> Int
}

protocol PlayerProblemsInteractorInput: AnyObject {
}

protocol PlayerProblemsInteractorOutput: AnyObject {
}

protocol PlayerProblemsRouterInput: AnyObject {
    func openNextScreen()
    
    func openDiscussion(game: GameModel)
    
    func nextDisplay(presenter: PlayerProblemsViewOutput) -> PlayerProblemsViewInput
}
