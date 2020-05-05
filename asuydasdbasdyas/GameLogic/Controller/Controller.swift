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
    
    var jumpButton : ControllerButton?
    var attackButton : ControllerButton?
    
    private var buttons : [ControllerButton] = []
    
    init(_ overlayScene: SKScene?){
        if let scene = overlayScene{
            setupController(scene)
        }
    }
    
    
    func checkButtonHit(_ point: CGPoint)
    {
        for button in buttons {
            if button.checkHit(point) {
                //print("button hit: " + (button.node.name ?? "Unnamed Node"))
                button.action!()
            }
        }
    }
    
    private func setupController(_ overlayScene: SKScene)
    {
        leftStick = ControllerStick(overlayScene)
        jumpButton = ControllerButton(overlayScene, "ControllerJumpButton")
        attackButton = ControllerButton(overlayScene, "ControllerAttackButton")
        
        jumpButton!.action = {() -> Void in print("Jump Button Pressed")}
        attackButton!.action = {() -> Void in return}
        
        buttons.append(jumpButton!)
        buttons.append(attackButton!)
    }
}

