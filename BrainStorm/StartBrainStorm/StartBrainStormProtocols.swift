//
//  StartBrainStormProtocols.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/14/22.
//  
//

import Foundation

protocol StartBrainStormModuleInput {
    var moduleOutput: StartBrainStormModuleOutput? { get }
}

protocol StartBrainStormModuleOutput: AnyObject {
    
    func addCard(savedCard: SavedCard)
}

protocol StartBrainStormViewInput: AnyObject {
}

protocol StartBrainStormViewOutput: AnyObject {
    func viewDidLoad()
    
    func startBrainStorm(name: String)
    
    func openEnterPlayerName(count: Int)
    
    func getDateString() -> String
}

protocol StartBrainStormInteractorInput: AnyObject {
}

protocol StartBrainStormInteractorOutput: AnyObject {
}

protocol StartBrainStormRouterInput: AnyObject {
    func openEnterPlayerName(count: Int)
}
