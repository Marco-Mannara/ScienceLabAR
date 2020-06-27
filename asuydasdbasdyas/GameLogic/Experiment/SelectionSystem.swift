//
//  SelectionSystem.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 16/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class SelectionSystem {
    
    var toolSelected : Tool? = nil
    
    private var experiment : Experiment
    
    init(_ experiment : Experiment){
        self.experiment = experiment
    }
    
    func selectTool(_ tool : Tool) -> Bool{
        if toolSelected == nil{
            toolSelected = tool
            return true
        }
        return false
    }
    
    func deselectTool(_ tool : Tool){
        if tool.isEqual(toolSelected){
            toolSelected = nil
        }
    }
    
    func clearSelection(){
        toolSelected = nil
    }
}
