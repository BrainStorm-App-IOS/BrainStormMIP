//
//  StartBrainStormContainer.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//  
//

import UIKit

final class StartBrainStormContainer {
    let input: StartBrainStormModuleInput
    let viewController: UIViewController
    private(set) weak var router: StartBrainStormRouterInput!
    
    
    class func assemble(with context: StartBrainStormContext) -> StartBrainStormContainer {
        let router = StartBrainStormRouter()
        let interactor = StartBrainStormInteractor()
        let presenter = StartBrainStormPresenter(router: router, interactor: interactor, game: context.game)
        let viewController = StartBrainStormViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return StartBrainStormContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: StartBrainStormModuleInput, router: StartBrainStormRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct StartBrainStormContext {
    weak var moduleOutput: StartBrainStormModuleOutput?
    var game: GameModel
}
