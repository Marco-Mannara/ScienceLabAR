//
//  ExperimentProgression.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 15/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import UIKit
import SceneKit


class GoalSystem{
    var goals : [Goal] = []
    var goalProgress : Int = 0
    
    func eventNotify(_ tool0 : Tool, _ tool1: Tool){
        checkGoals([tool0,tool1])
    }
    
    func eventNotify(_ reaction : Reaction){
        checkGoals([reaction])
    }
    
    func updateExperimentProgression(){
        if let gameViewController = GameManager.getInstance().viewController as? GameViewController{
            gameViewController.progressIndicator.text = "\(goalProgress)/\(goals.count)"
        }
        else if let arViewController = GameManager.getInstance().viewController as? ARViewController{
            arViewController.progressIndicator.text = "\(goalProgress)/\(goals.count)"
        }
    }
    
    private func presentLevelCompleteAlert(){
        DispatchQueue.main.async {
            let vc = GameManager.getInstance().viewController!
            let alert = UIAlertController(title: "Congratulazioni", message: "Hai completato l'esperimento. Puoi ritornare al menu principale oppure rimanere nel livello ancora un po'", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Torna al Menu", style: .default, handler: {(action) -> Void in
                vc.performSegue(withIdentifier: "selectionMenu", sender: nil)
            }))
            alert.addAction(UIAlertAction(title: "Rimani", style: .cancel, handler: nil))
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    private func checkGoals(_ params : [Any]){
        for g in goals{
            if !g.completed && g.checkCompletition(params){
                goalProgress += 1
                updateExperimentProgression()
            }
        }
    }
}
