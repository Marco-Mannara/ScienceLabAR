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
    var goalProgress : Int = 0
    
    func onToolAction(_ tool0 : Tool, _ tool1: Tool){
        for g in goals{
            if !g.completed && g.checkCompletition(tool0, tool1){
                goalProgress += 1
                updateExperimentProgression()
            }
        }
    }
    
    func updateExperimentProgression(){
        if let gameViewController = GameManager.getInstance().viewController as? GameViewController{
            gameViewController.progressIndicator.text = "\(goalProgress)/\(goals.count)"
        }
        else if let arViewController = GameManager.getInstance().viewController as? ARViewController{
              arViewController.progressIndicator.text = "\(goalProgress)/\(goals.count)"
        }
    }
}
