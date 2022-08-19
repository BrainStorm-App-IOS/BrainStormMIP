//
//  EnterPlayerNameContainer.swift
//  BrainStorm
//
//  Created by Кирилл Санников on 18.08.2022.
//  
//

import UIKit

final class EnterPlayerNameContainer {
    let input: EnterPlayerNameModuleInput
    let viewController: UIViewController
    private(set) weak var router: EnterPlayerNameRouterInput!
    
    class func assemble(with context: EnterPlayerNameContext) -> EnterPlayerNameContainer {
        let router = EnterPlayerNameRouter()
        let interactor = EnterPlayerNameInteractor()
        let presenter = EnterPlayerNamePresenter(router: router, interactor: interactor, count: context.count)
        let viewController = EnterPlayerNameViewController(output: presenter, currPlayer: 1)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return EnterPlayerNameContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: EnterPlayerNameModuleInput, router: EnterPlayerNameRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct EnterPlayerNameContext {
    weak var moduleOutput: EnterPlayerNameModuleOutput?
    var count: Int
}
