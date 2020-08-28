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
    var completed : Bool = false
    //private var condition : (Tool, Tool) -> Bool
    
    init(_ name : String){
        self.name = name
    }
    
    func checkCompletition(_ params : [Any]) -> Bool{
        return true
    }
}
