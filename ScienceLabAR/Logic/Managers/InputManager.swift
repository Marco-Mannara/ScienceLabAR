//
//  InputManager.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 17/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit


class InputManager{
    
    var enabled : Bool = false
    
    func onTap(_ sceneView: SCNView,_ position: CGPoint){
        if enabled{
            
            if let firstResult = sceneView.hitTest(position, options: nil).first{
                if let hitEntity = firstResult.node.entity as? EntityHitProtocol{
                    //print("hit hittable")
                    hitEntity.hit(firstResult)
                }
                if let hitTool = firstResult.node.entity as? Tool{
                    GameManager.getInstance().sceneManager?.currentExperiment?.onToolTap(hitTool)
                }
            }
            else{
                //print("miss")
            }
        }
    }
}
