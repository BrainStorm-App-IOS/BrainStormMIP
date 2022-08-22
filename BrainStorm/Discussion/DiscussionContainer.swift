//
//  DiscussionContainer.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 20.08.2022.
//
//

import UIKit

final class DiscussionContainer {
    let input: DiscussionModuleInput
    let viewController: UIViewController
    private(set) weak var router: DiscussionRouterInput!
    
    class func assemble(with context: DiscussionContext) -> DiscussionContainer {
        let router = DiscussionRouter()
        let interactor = DiscussionInteractor()
        let presenter = DiscussionPresenter(router: router, interactor: interactor, teamName: context.teamName, theme: context.theme, countOfPlayers: context.countOfPlayers)
        let viewController = DiscussionViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return DiscussionContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: DiscussionModuleInput, router: DiscussionRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct DiscussionContext {
    weak var moduleOutput: DiscussionModuleOutput?
    
    let teamName : String
    let theme : String
    let countOfPlayers : Int
    
}
