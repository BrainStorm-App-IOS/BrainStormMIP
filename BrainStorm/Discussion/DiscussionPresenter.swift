//
//  DiscussionPresenter.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 20.08.2022.
//
//

import Foundation

final class DiscussionPresenter {
    weak var view: DiscussionViewInput?
    weak var moduleOutput: DiscussionModuleOutput?
    
    private let router: DiscussionRouterInput
    private let interactor: DiscussionInteractorInput
    
    private var game: GameModel
    
    init(router: DiscussionRouterInput, interactor: DiscussionInteractorInput, game: GameModel) {
        self.router = router
        self.interactor = interactor
        self.game = game
        
        self.game.stage = 2
        
        saveGame()
    }
}

extension DiscussionPresenter: DiscussionModuleInput {
}

extension DiscussionPresenter: DiscussionViewOutput {
    func saveGame() {
        interactor.updateGamesonFirebase(game: game)
    }
    
    func addProblem(problem: String) {
        var result = ResultModel()
        result.add(problem: problem)
        game.results.append(result)
    }
    
    func getTeamName() -> String {
        return game.name
    }
    
    func getProblems() -> [String] {
        var problems: [String] = []
        for person in game.persons {
            for problem in person.writtenProblems {
                if problem != "" {
                    problems.append(problem)
                }
            }
        }
        
        return problems
    }
    
    func getTheme() -> String {
        return game.theme
    }
    
    func getCountOfProblems() -> Int {
        return game.countOfPersons
    }
    
    func openNextField() {
        game.results = game.results.shuffled()
        router.openNextField(game: game)
    }
    
}

extension DiscussionPresenter: DiscussionInteractorOutput {
}
