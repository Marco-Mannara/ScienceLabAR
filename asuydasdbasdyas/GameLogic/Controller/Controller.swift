//
//  Controller.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 22/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SceneKit
import SpriteKit

class Controller
{
    var leftStick : ControllerStick?
    var rightStick : ControllerStick?
    
    var buttons : [ControllerButton] = []
    
    init(_ overlayScene: SKScene?){
        if let scene = overlayScene{
            setupController(scene)
        }
    }
    
    func checkButtonHit(_ point: CGPoint)
    {
        for button in buttons {
            if button.checkHit(point.toSimdFloat2()) {
                button.action!()
            }
        }
    }
    
    private func setupController(_ overlayScene: SKScene)
    {
        leftStick = ControllerStick(overlayScene)
        let jumpButton = ControllerButton(overlayScene, "ControllerJumpButton")
        let attackButton = ControllerButton(overlayScene, "ControllerAttackButton")
        
        jumpButton.action = {() -> Void in return}
        attackButton.action = {() -> Void in return}
        
        buttons.append(jumpButton)
        buttons.append(attackButton)
    }
}

