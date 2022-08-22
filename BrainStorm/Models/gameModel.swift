//
//  GameModel.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation

final class GameModel {
    final let end : Bool
    final let name : String
    final let persons : [PersonModel]
    final let results : [ResultModel]
    final let stage : Int
    final let stoppedPerson : Int
    final let theme : String
    final let timer : Int
    init(end : Bool, name : String, persons : [PersonModel], results : [ResultModel], stage : Int, stoppedPerson : Int, theme: String, timer : Int) {
        self.end = end
        self.name = name
        self.persons = persons
        self.results = results
        self.stage = stage
        self.stoppedPerson = stoppedPerson
        self.theme = theme
        self.timer = timer
    }
}
