//
//  PersonModel.swift
//  BrainStorm
//
//  Created by Андрей Лосюков on 22.08.2022.
//

import Foundation

struct PersonModel : Codable{
    var name : String?
    var pickedProblem : String?
    var solution : String?
    var writtenProblems : [String?]
    
    init() {
        name = nil
        pickedProblem = nil
        solution = nil
        writtenProblems = []
    }
    
    init(name : String?, pickedProblem : String?, solution : String?, writtenProblems : [String?]) {
        self.name = name
        self.pickedProblem = pickedProblem
        self.solution = solution
        self.writtenProblems = writtenProblems
    }
}
