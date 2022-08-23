//
//  StartBrainStormPresenter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//  
//

import Foundation

final class StartBrainStormPresenter {
    weak var view: StartBrainStormViewInput?
    weak var moduleOutput: StartBrainStormModuleOutput?
    
    private let router: StartBrainStormRouterInput
    private let interactor: StartBrainStormInteractorInput
    private var game: GameModel
    
    init(router: StartBrainStormRouterInput, interactor: StartBrainStormInteractorInput, game: GameModel) {
        self.router = router
        self.interactor = interactor
        self.game = game
    }
}

extension StartBrainStormPresenter: StartBrainStormModuleInput {
}

extension StartBrainStormPresenter: StartBrainStormViewOutput {
    func openEnterPlayerName() {
        router.openEnterPlayerName(game: game)
    }
    
    func viewDidLoad() {
        
    }
    
    func setTheme(theme: String) {
        game.theme = theme
    }
    
    func setCountOfPlayers(countOfPlayers: Int) {
        game.countOfPlayers = countOfPlayers
    }
    
    func setTeamName(teamName: String) {
        game.name = teamName
    }
    
    func getDateString() -> String {
        let date = Date()
        let calendar = Calendar.current
        let day = calendar.component(.day, from:  date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        
        return "\(day).\(month).\(year)"
    }
    
}

extension StartBrainStormPresenter: StartBrainStormInteractorOutput {
}

