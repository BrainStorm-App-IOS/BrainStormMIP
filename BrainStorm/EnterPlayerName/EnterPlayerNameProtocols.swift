//
//  EnterPlayerNameProtocols.swift
//  BrainStorm
//
//  Created by Кирилл Санников on 18.08.2022.
//  
//

import Foundation

protocol EnterPlayerNameModuleInput {
    var moduleOutput: EnterPlayerNameModuleOutput? { get }
}

protocol EnterPlayerNameModuleOutput: AnyObject {
}

protocol EnterPlayerNameViewInput: AnyObject {
}

protocol EnterPlayerNameViewOutput: AnyObject {
    
    func nextPlayer()
    
    func addPerson(name: String)
}

protocol EnterPlayerNameInteractorInput: AnyObject {
}

protocol EnterPlayerNameInteractorOutput: AnyObject {
}

protocol EnterPlayerNameRouterInput: AnyObject {
    func nextDisplay(cntPlayer: Int, presenter: EnterPlayerNameViewOutput) -> EnterPlayerNameViewInput
    func openPlayerProblems(game: GameModel)
}
