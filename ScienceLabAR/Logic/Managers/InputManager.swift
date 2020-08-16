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
            let hitTest = sceneView.hitTest(position, options: nil)
            
            if let firstResult = hitTest.first{
                if let hitTool = firstResult.node.entity as? Tool{
                    GameManager.getInstance().sceneManager?.currentExperiment?.onToolTap(hitTool)
                }
                if hitTest.count == 1{
                    if let hitEntity = firstResult.node.entity as? EntityHitProtocol{
                        //print("hit hittable")
                        hitEntity.hit(firstResult)
                    }
                }
                else if hitTest.count > 1{
                    if let hitTool = hitTest[1].node.entity as? Tool{
                        GameManager.getInstance().sceneManager?.currentExperiment?.onToolTap(hitTool)
                    }
                    else if let hitEntity = firstResult.node.entity as? EntityHitProtocol{
                        //print("hit hittable")
                        hitEntity.hit(firstResult)
                    }
                }
            }
        }
    }
}
