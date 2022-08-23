//
//  ResultModel.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation

struct ResultModel : Codable {
    var problem : String?
    var solution : String?
    var rating : Int?
    
    init() {
        problem = nil
        solution = nil
        rating = nil
    }
    
    init(problem : String?, solution : String?, rating : Int?) {
        self.problem = problem
        self.solution = solution
        self.rating = rating
    }
}
