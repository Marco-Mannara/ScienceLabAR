//
//  SelectionSystem.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 16/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class SelectionSystem {
    
    var selectedTool : Tool? = nil
    
    private var experiment : Experiment
    
    init(_ experiment : Experiment){
        self.experiment = experiment
    }
    
    func selectTool(_ tool : Tool) -> Bool{
        if selectedTool == nil{
            selectedTool = tool
            return true
        }
        else{
            selectedTool?.state?.enter(StateIdle.self)
            selectedTool = tool
            return true
        }
    }
    
    func clearSelection(){
        selectedTool = nil
    }
}
