//
//  PlayerProblemsPresenter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//  
//

import Foundation

final class PlayerProblemsPresenter {
    weak var view: PlayerProblemsViewInput?
    weak var moduleOutput: PlayerProblemsModuleOutput?
    
    private let router: PlayerProblemsRouterInput
    private let interactor: PlayerProblemsInteractorInput
    
    private var game: GameModel
    private var currPlayer: Int = 0
    
    init(router: PlayerProblemsRouterInput, interactor: PlayerProblemsInteractorInput, game: GameModel) {
        self.router = router
        self.interactor = interactor
        self.game = game
    }
}

extension PlayerProblemsPresenter: PlayerProblemsModuleInput {
}

extension PlayerProblemsPresenter: PlayerProblemsViewOutput {
    func nextPlayer() {
        if (currPlayer == game.countOfPlayers - 1) {
            router.openDiscussion(game: game)
            //router.openNextScreen()
        } else {
            currPlayer += 1
            view = router.nextDisplay(presenter: self)
        }
    }
    
    func openNextScreen() {
        router.openNextScreen()
    }
    
    func getCurrPlayer() -> Int {
        return currPlayer
    }
    
    func getName() -> String {
        return game.persons[currPlayer].name
    }
    
    func addProblems() {
        game.persons[currPlayer].writtenProblems.append("")
    }
    
    func rewriteProblem(at index: Int, write problem: String) {
        game.persons[currPlayer].writtenProblems[index] = problem
    }
    
    func getProblem(at index: Int) -> String {
        return game.persons[currPlayer].writtenProblems[index]
    }
    
    func getTheme() -> String {
        return game.theme
    }
    
    func getCountofProblems() -> Int {
        return game.persons[currPlayer].writtenProblems.count
    }
}

extension PlayerProblemsPresenter: PlayerProblemsInteractorOutput {
}
