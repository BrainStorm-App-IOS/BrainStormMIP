//
//  GameParser.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation
import Firebase

final class GameParser {
    static func parseGame(gameDict : [String : Any]?) -> GameModel {
        var game = GameModel()
        game.end = gameDict?["end"] as? Bool ?? false
        game.name = gameDict?["name"] as? String ?? ""
        game.countOfPersons = gameDict?["countOfPersons"] as? Int ?? 0
        game.persons =  PersonParser.parseAllPersons(persons:gameDict?["persons"] as?[[String : Any?]] ?? [])
        game.results =  ResultParser.parseAllResults(results:gameDict?["results"] as?[[String : Any?]] ?? [])
        game.stage = gameDict?["stage"] as? Int ?? 0
        game.stoppedPerson = gameDict?["stoppedPerson"] as? Int ?? 0
        game.theme = gameDict?["theme"] as? String ?? ""
        game.timer = gameDict?["timer"] as? Int ?? 0
        game.date = gameDict?["game"] as? String ?? ""
        return game
    }
    
    static func getDataFromGameModel(model : GameModel) -> [String : Any] {
        return [
            "persons" : PersonParser.getDataFromPersons(models: model.persons),
            "countOfPeoples" : model.countOfPersons ?? "",
            "name" : model.name ?? "",
            "results" : ResultParser.getDataFromResults(models: model.results),
            "stage" : model.stage ?? "",
            "timer" : model.timer ?? "",
            "theme" : model.theme ?? "",
            "end" : model.end ?? "",
            "stoppedPerson" : model.stoppedPerson ?? "",
            "date" : model.date ?? ""
        ]
    }
}
