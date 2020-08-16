//
//  Goals.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 16/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class Goal{
    var name : String
    var explanation : String?
    var completed : Bool = false
    private var condition : (Tool, Tool) -> Bool
    
    init(_ name : String,_ condition : @escaping (Tool, Tool) -> Bool){
        self.name = name
        self.condition = condition
    }
    
    func checkCompletition(_ tool: Tool, _ secondTool: Tool) -> Bool{
        if completed { return true }
        if condition(tool,secondTool){
            completed = true
            print("goal \(name) achieved")
            return true
        }
        else{
            print("goal \(name) not achieved")
            return false
        }
    }
}
