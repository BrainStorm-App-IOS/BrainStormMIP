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
    private let teamName : String
    private let theme : String
    private let countOfPlayers : Int
    
    init(router: DiscussionRouterInput, interactor: DiscussionInteractorInput, teamName: String, theme: String, countOfPlayers : Int) {
        self.router = router
        self.interactor = interactor
        self.teamName = teamName
        self.theme = theme
        self.countOfPlayers = countOfPlayers
    }
}

extension DiscussionPresenter: DiscussionModuleInput {
}

extension DiscussionPresenter: DiscussionViewOutput {
}

extension DiscussionPresenter: DiscussionInteractorOutput {
}
