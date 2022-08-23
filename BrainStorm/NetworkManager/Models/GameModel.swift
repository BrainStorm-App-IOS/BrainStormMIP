//
//  GameModel.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation

struct GameModel : Codable {
    var end : Bool?
    var name : String?
    // to do
    var countOfPersons : Int?
    var persons : [PersonModel]
    var results : [ResultModel]
    var stage : Int?
    var stoppedPerson : Int?
    var theme : String?
    var timer : Int?
    var date : String?
    
    init() {
        end = nil
        name = nil
        countOfPersons = nil
        persons = []
        results = []
        stage = nil
        stoppedPerson = nil
        theme = nil
        timer = nil
        date = nil
    }
    
    init(end : Bool, name : String, countOfPersons : Int?, persons : [PersonModel], results : [ResultModel], stage : Int, stoppedPerson : Int, theme: String, timer : Int, date : String) {
        self.end = end
        self.name = name
        self.countOfPersons = countOfPersons
        self.persons = persons
        self.results = results
        self.stage = stage
        self.stoppedPerson = stoppedPerson
        self.theme = theme
        self.timer = timer
        self.date = date
    }
}
