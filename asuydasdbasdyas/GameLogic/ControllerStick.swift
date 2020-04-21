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
    var center: simd_float2 = simd_float2.zero
    var direction : simd_float2 = simd_float2.zero
    var deadZoneRadius : Float = 30.0
    var maxRadius : Float = 50.0
    
    func pressed(_ point: CGPoint){
        
        center = simd_float2(Float(point.x),Float(point.y))
        isPressed = true
        print("stick pressed.")
    }
    
    func updateState(_ updatedPosition: CGPoint){
        if isPressed {
            let simdPosition = simd_float2(Float(updatedPosition.x), Float(updatedPosition.y))
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
        print("stick released.")
        direction = simd_float2.zero
        isPressed = false
    }
}
