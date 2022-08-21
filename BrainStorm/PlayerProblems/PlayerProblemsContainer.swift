//
//  PlayerProblemsContainer.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//  
//

import UIKit

final class PlayerProblemsContainer {
    let input: PlayerProblemsModuleInput
    let viewController: UIViewController
    private(set) weak var router: PlayerProblemsRouterInput!
    
    class func assemble(with context: PlayerProblemsContext) -> PlayerProblemsContainer {
        let router = PlayerProblemsRouter()
        let interactor = PlayerProblemsInteractor()
        let presenter = PlayerProblemsPresenter(router: router, interactor: interactor)
        let viewController = PlayerProblemsViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return PlayerProblemsContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: PlayerProblemsModuleInput, router: PlayerProblemsRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct PlayerProblemsContext {
    weak var moduleOutput: PlayerProblemsModuleOutput?
}
