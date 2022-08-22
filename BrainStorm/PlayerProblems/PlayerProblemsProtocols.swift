//
//  PlayerProblemsProtocols.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/20/22.
//  
//

import Foundation

protocol PlayerProblemsModuleInput {
    var moduleOutput: PlayerProblemsModuleOutput? { get }
}

protocol PlayerProblemsModuleOutput: AnyObject {
    
}

protocol PlayerProblemsViewInput: AnyObject {
}

protocol PlayerProblemsViewOutput: AnyObject {
    func openNextScreen()
}

protocol PlayerProblemsInteractorInput: AnyObject {
}

protocol PlayerProblemsInteractorOutput: AnyObject {
}

protocol PlayerProblemsRouterInput: AnyObject {
    func openNextScreen()
}
