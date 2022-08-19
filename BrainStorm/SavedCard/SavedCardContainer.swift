//
//  SavedCardContainer.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//  
//

import UIKit

final class SavedCardContainer {
    let input: SavedCardModuleInput
    let viewController: UIViewController
    private(set) weak var router: SavedCardRouterInput!
    
    class func assemble(with context: SavedCardContext) -> SavedCardContainer {
        let router = SavedCardRouter()
        let interactor = SavedCardInteractor()
        let presenter = SavedCardPresenter(router: router, interactor: interactor)
        let viewController = SavedCardViewController(output: presenter)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        router.viewController = viewController
        
        return SavedCardContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: SavedCardModuleInput, router: SavedCardRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct SavedCardContext {
    weak var moduleOutput: SavedCardModuleOutput?
    
}
