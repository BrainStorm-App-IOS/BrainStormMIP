//
//  OpenedCardProtocols.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/15/22.
//  
//

import Foundation

protocol OpenedCardModuleInput {
    var moduleOutput: OpenedCardModuleOutput? { get }
}

protocol OpenedCardModuleOutput: AnyObject {
}

protocol OpenedCardViewInput: AnyObject {
}

protocol OpenedCardViewOutput: AnyObject {
}

protocol OpenedCardInteractorInput: AnyObject {
}

protocol OpenedCardInteractorOutput: AnyObject {
}

protocol OpenedCardRouterInput: AnyObject {
}
