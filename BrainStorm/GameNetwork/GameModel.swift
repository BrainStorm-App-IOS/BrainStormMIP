//
//  GameModel.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation
import Firebase

struct GameModel {
    var countOfPlayers: Int!
    var end : Bool?
    var name : String!
    var persons : [PersonModel] = []
    var results : [ResultModel] = []
    var stage : Int = 0
    var stoppedPerson : Int?
    var theme : String!
    var timer : Int?
    lazy var db = Firestore.firestore()
    
//    init(end : Bool, name : String, persons : [PersonModel], results : [ResultModel], stage : Int, stoppedPerson : Int, theme: String, timer : Int) {
//        self.end = end
//        self.name = name
//        self.persons = persons
//        self.results = results
//        self.stage = stage
//        self.stoppedPerson = stoppedPerson
//        self.theme = theme
//        self.timer = timer
//    }
}
