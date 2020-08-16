//
//  ExperimentProgression.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 15/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class GoalSystem{
    var goals : [Goal] = []
    private (set) var goalProgress : Int = 0

    func onToolAction(_ tool0 : Tool, _ tool1: Tool){
        for g in goals{
            let result = g.checkCompletition(tool0, tool1)
            if result{
                goalProgress += 1
                break
            }
        }
    }
    
    private func updateExperimentProgression(){
        
    }
}
