//
//  PersonNetwork.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation

final class PersonParser {
    static func parseAllPersons(persons : [[String : Any?]]) -> [PersonModel] {
        var parsedPersons : [PersonModel] = []
        persons.forEach { map in
            var person = PersonModel()
            
            if let pickedProblem = map["pickedProblem"] as? String? {
                person.pickedProblem = pickedProblem
            }
            
            if let solution = map["solution"] as? String? {
                person.solution = solution
            }
            
            if let name = map["name"] as? String? {
                person.name = name
            }
            
            if let writtenProblems = map["writtenProblems"] as? [String?] {
                person.writtenProblems = writtenProblems
            }
            
            parsedPersons.append(person)
        }
        return parsedPersons
    }
    
    static func getDataFromPersons(models : [PersonModel]) -> [[String: Any?]] {
        var data : [[String: Any?]] = []
        for model in models {
            data.append([
                "name" : model.name,
                "pickedProblem" : model.pickedProblem,
                "solution" : model.solution,
                "writtenProblems" : model.writtenProblems
            ])
        }
        return data
    }
}
