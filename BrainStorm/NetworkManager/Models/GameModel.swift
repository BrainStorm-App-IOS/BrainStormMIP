//
//  GameModel.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation

final class GameModel {
    var gameId : String = ""
    var end : Bool?
    var name : String!
    var countOfPersons : Int!
    var persons : [PersonModel] = []
    var results : [ResultModel] = []
    var stage : Int = 0
    var stoppedPerson : Int?
    var theme : String!
    var timer : Int?
    var date : String?
}
