//
//  DiscussionProtocols.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 20.08.2022.
//
//

import Foundation

protocol DiscussionModuleInput {
    var moduleOutput: DiscussionModuleOutput? { get }
}

protocol DiscussionModuleOutput: AnyObject {
}

protocol DiscussionViewInput: AnyObject {
}

protocol DiscussionViewOutput: AnyObject {
    func openNextField()
}

protocol DiscussionInteractorInput: AnyObject {
}

protocol DiscussionInteractorOutput: AnyObject {
}

protocol DiscussionRouterInput: AnyObject {
    func openNextField()
}
