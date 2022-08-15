//
//  SavedCardProtocols.swift
//  BrainStorm
//
//  Created by Максим Никитин on 8/13/22.
//  
//

import Foundation

protocol SavedCardModuleInput {
    var moduleOutput: SavedCardModuleOutput? { get }
}

protocol SavedCardModuleOutput: AnyObject {
}

protocol SavedCardViewInput: AnyObject {
    func reloadData()
}

protocol SavedCardViewOutput: AnyObject {
    func viewDidLoad()
    
    func getItem(in index: Int) -> SavedCard
    
    func getCount() -> Int
    
    func openBrainStromSettings()
}

protocol SavedCardInteractorInput: AnyObject {
}

protocol SavedCardInteractorOutput: AnyObject {
}

protocol SavedCardRouterInput: AnyObject {
    func openBrainStormSettings(output: StartBrainStormModuleOutput)
}
