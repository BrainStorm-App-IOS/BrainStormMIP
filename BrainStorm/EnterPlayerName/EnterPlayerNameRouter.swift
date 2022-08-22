//
//  EnterPlayerNameRouter.swift
//  BrainStorm
//
//  Created by Кирилл Санников on 18.08.2022.
//  
//

import UIKit

final class EnterPlayerNameRouter {
    weak var viewController: UIViewController?
}

extension EnterPlayerNameRouter: EnterPlayerNameRouterInput {
    func nextModule(names: [String]) {
        // to do
    }
    
    func nextDisplay(cntPlayer: Int, presenter: EnterPlayerNameViewOutput) -> EnterPlayerNameViewInput {
        let view = EnterPlayerNameViewController(output: presenter, currPlayer: cntPlayer)
        MainNavigationController.navigationController.pushViewController(view, animated: true)
        return view
    }
    
}

