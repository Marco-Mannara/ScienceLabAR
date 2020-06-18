//
//  SelectionSystem.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 16/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class SelectionSystem {
    
    var toolSelectedA : Tool? = nil
    var toolSelectedB : Tool? = nil
    
    private var experiment : Experiment
    
    init(_ experiment : Experiment){
        self.experiment = experiment
    }
    
    func selectTool(_ tool : Tool) -> Bool{
        if toolSelectedA == nil{
            toolSelectedA = tool
            //tool.isSelected = true
            return true
        }
        else if toolSelectedB == nil{
            toolSelectedB = tool
            //tool.isSelected = true
            return true
        }
        return false
    }
    
    func deselectTool(_ tool : Tool){
        //tool.isSelected = false
        if tool.isEqual(toolSelectedA){
            toolSelectedA = nil
        }
        else if tool.isEqual(toolSelectedB){
            toolSelectedB = nil
        }
    }
}
