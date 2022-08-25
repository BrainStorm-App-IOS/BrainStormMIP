//
//  ResultModel.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation

final class ResultModel {
    var problem : String?
    var solution : String?
    var rating : Int = 0
    
    func add(problem: String) {
        self.problem = problem
    }
}
