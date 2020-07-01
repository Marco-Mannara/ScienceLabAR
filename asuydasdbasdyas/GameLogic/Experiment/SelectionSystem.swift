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
        else{
            toolSelected?.state?.enter(StateIdle.self)
            toolSelected = tool
            return true
        }
    }
    
    func clearSelection(){
        toolSelected = nil
    }
}
