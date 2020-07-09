//
//  SwiftUIView.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 18/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import GameplayKit

class ControllerStick{
    
    var isPressed : Bool = false
    var direction : simd_float2 = simd_float2.zero
    
    private var center: simd_float2 = simd_float2.zero
    private var deadZoneRadius : Float = 30.0
    private var maxRadius : Float = 50.0
    
    private var hudScene : SKNode?
    private var stickBaseNode : SKNode?
    private var stickTopNode : SKNode?
    
    init()
    {
    }
    
    init(_ hudScene : SKNode){
        self.hudScene = hudScene
        self.stickBaseNode = hudScene.childNode(withName: "ControllerStickBase")!
        self.stickTopNode = self.stickBaseNode!.childNode(withName: "ControllerStickTop")!
    }
    
    func pressed(_ point: CGPoint)
    {
        
        center = simd_float2(point.x, point.y)
        
        stickBaseNode?.position = CGPoint.screenToSpriteSceneCoordinates(point)
        
        stickTopNode?.position = CGPoint.zero
        
        isPressed = true
        //print("stick pressed.")
    }
    
    func updateState(_ updatedPosition: CGPoint){
        if isPressed {
            
            let topNodePosition = updatedPosition - center
            let simdPosition = simd_float2(updatedPosition.x, updatedPosition.y)
            
            stickTopNode?.position = CGPoint(x: topNodePosition.x, y: -topNodePosition.y)
            
            direction = simdPosition - center
            
            let magnitude = Vector3(direction.x,direction.y,0.0).magnitude()
            
            //print(magnitude)
            if magnitude <= deadZoneRadius{
                direction = simd_float2.zero
            }
            else{
                direction = simd_normalize(direction / maxRadius)
            }
        }
    }
    
    func released()
    {
        //print("stick released.")
        stickTopNode?.position = CGPoint.zero
        direction = simd_float2.zero
        
        isPressed = false
    }
}
