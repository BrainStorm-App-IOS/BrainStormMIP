//
//  ResultNetwork.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation

final class ResultParser {
    
    static func parseAllResults(results : [[String : Any?]]) -> [ResultModel] {
        var parsedResults : [ResultModel] = []
        results.forEach { map in
            
            var result = ResultModel()
            if let problem = map["problem"] as? String? {
                result.problem = problem
            }
            if let solution = map["solution"] as? String? {
                result.solution = solution
            }
            if let rating = map["results"] as? Int? {
                result.rating = rating
            }
            
            parsedResults.append(result)
        }
        return parsedResults
    }
    
    static func getDataFromResults(models : [ResultModel]) -> [[String: Any?]] {
        var data : [[String: Any?]] = []
        for model in models {
            data.append([
                "solution" : model.solution,
                "problem" : model.problem,
                "rating" : model.rating,
            ])
        }
        return data
    }
}
