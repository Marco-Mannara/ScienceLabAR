//
//  ReactionGoal.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 28/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class ReactionGoal : Goal{
    private var condition : (Reaction) -> Bool
    
    init(_ name: String, _ condition: @escaping (Reaction)-> Bool) {
        self.condition = condition
        super.init(name)
    }
    
    override func checkCompletition(_ params : [Any]) -> Bool {
        if completed { return true }
        if params.count < 1 {return false}
        guard let reaction = params.first as? Reaction else{
            fatalError("")
        }
        if condition(reaction){
            completed = true
            print("goal \(name) achieved")
            return true
        }
        else{
            return false
        }
    }
}
