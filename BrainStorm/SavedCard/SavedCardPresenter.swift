//
//  SavedCardPresenter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//  
//

import Foundation

final class SavedCardPresenter {
    weak var view: SavedCardViewInput?
    weak var moduleOutput: SavedCardModuleOutput?
    
    private let router: SavedCardRouterInput
    private let interactor: SavedCardInteractorInput
    
    private var savedCards: [GameModel] = []
    
    init(router: SavedCardRouterInput, interactor: SavedCardInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension SavedCardPresenter: SavedCardModuleInput {
}

extension SavedCardPresenter: PlayerProblemsModuleOutput {
}

extension SavedCardPresenter: DiscussionModuleOutput {
}

extension SavedCardPresenter: TeammateCardSolutionModuleOutput {
}

extension SavedCardPresenter: SavedCardViewOutput {
    func continueGame(at index: Int) {
        let stage: Int = savedCards[index].stage ?? 0
        let stopedAtPreson: Int = savedCards[index].stoppedPerson ?? 0
        print(stage)
        print(stopedAtPreson)
        
        if stage == 1 {
            let PlayerProblemsContext = PlayerProblemsContext(moduleOutput: self, game: savedCards[index], currPlayer: stopedAtPreson)
            let PlayerProblemsContainer = PlayerProblemsContainer.assemble(with: PlayerProblemsContext)
            
            PlayerProblemsContainer.viewController.hidesBottomBarWhenPushed = true
            
            MainNavigationController.navigationController.pushViewController(PlayerProblemsContainer.viewController, animated: true)
        }
        else if stage == 2 {
            let DiscussionContext = DiscussionContext(moduleOutput: self, game: savedCards[index])
            let DiscussionContainer = DiscussionContainer.assemble(with: DiscussionContext)
            
            DiscussionContainer.viewController.hidesBottomBarWhenPushed = true
            
            MainNavigationController.navigationController.pushViewController(DiscussionContainer.viewController, animated: true)
        }
        else if stage == 3 {
            let TeammateCardSolutionContext = TeammateCardSolutionContext(moduleOutput: self,
                                                                          game: savedCards[index],
                                                                          currInd: stopedAtPreson)
            let TeammateCardSolutionContainer = TeammateCardSolutionContainer.assemble(with: TeammateCardSolutionContext)
            
            TeammateCardSolutionContainer.viewController.hidesBottomBarWhenPushed = true
            
            MainNavigationController.navigationController.pushViewController(TeammateCardSolutionContainer.viewController, animated: true)
        }
        else {
            MainNavigationController.navigationController.pushViewController(SliderViewController(game: savedCards[index], counter: savedCards[index].countOfPersons), animated: true)
        }
    }
    
    

    func openBrainStromSettings() {
        router.openBrainStormSettings(output: self)
    }
    
    func getCount() -> Int {
        return savedCards.count
    }
    
    func getItem(in index: Int) -> GameModel {
        return savedCards[index]
    }
    
    func viewDidLoad() {
        interactor.getAllGames()
    }
    
    func didTapCard(savedCard: GameModel){
        router.openCard(output: self, savedCard: savedCard)
    }
    
}

extension SavedCardPresenter: SavedCardInteractorOutput {
    func didFail(with error: Error) {
    
    }
    
    func didObtain(games: [GameModel]) {
        self.savedCards = games
        view?.reloadData()
    }
    
    func updateGamesonFirebase(game: GameModel) {
        interactor.updateGamesonFirebase(game: game)
    }
    
    func saveGame(game: GameModel) {
        interactor.saveGame(game: game)
    }
}



extension SavedCardPresenter: StartBrainStormModuleOutput{
    func addCard(savedCard: GameModel) {
        savedCards.append(savedCard)
        view?.reloadData()
    }
    
}


extension SavedCardPresenter: OpenedCardModuleOutput{
    
}
