//
//  OpenedCardContainer.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/15/22.
//  
//

import UIKit

final class OpenedCardContainer {
    let input: OpenedCardModuleInput
    let viewController: UIViewController
    private(set) weak var router: OpenedCardRouterInput!
    
    class func assemble(with context: OpenedCardContext) -> OpenedCardContainer {
        let router = OpenedCardRouter()
        let interactor = OpenedCardInteractor()
        let presenter = OpenedCardPresenter(router: router, interactor: interactor)
        let viewController = OpenedCardViewController(output: presenter, savedCard: context.savedCard)
        
        presenter.view = viewController
        presenter.moduleOutput = context.moduleOutput
        
        interactor.output = presenter
        
        return OpenedCardContainer(view: viewController, input: presenter, router: router)
    }
    
    private init(view: UIViewController, input: OpenedCardModuleInput, router: OpenedCardRouterInput) {
        self.viewController = view
        self.input = input
        self.router = router
    }
}

struct OpenedCardContext {
    weak var moduleOutput: OpenedCardModuleOutput?
    var savedCard: SavedCard
}
