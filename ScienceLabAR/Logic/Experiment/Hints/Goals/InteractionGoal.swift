//
//  InteractionGoal.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 28/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
class InteractionGoal : Goal {
    
    private var condition : (Tool, Tool) -> Bool
    
    init(_ name: String, _ condition : @escaping (Tool, Tool) -> Bool) {
        self.condition = condition
        super.init(name)
    }
    
    override func checkCompletition(_ params : [Any]) -> Bool {
        if completed { return true }
        if params.count < 2 {
            print("Unsufficient number of parameters in goal \(name) check.")
            return false
        }
        guard let param0 = params[0] as? Tool, let param1 = params[1] as? Tool else {
            fatalError("Parameters passed to check completition are not of type \"Tool\"")
        }
        
        if condition(param0,param1){
            completed = true
            print("goal \(name) achieved")
            return true
        }
        else{
            return false
        }
    }
}
