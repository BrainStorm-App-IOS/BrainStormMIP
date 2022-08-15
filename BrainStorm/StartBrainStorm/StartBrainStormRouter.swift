//
//  StartBrainStormRouter.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//  
//

import UIKit

final class StartBrainStormRouter {
    weak var viewController: UIViewController?
}

extension StartBrainStormRouter: StartBrainStormRouterInput {
    func dismiss() {
        viewController?.dismiss(animated: true)
    }
}
