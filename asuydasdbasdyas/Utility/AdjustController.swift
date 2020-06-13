//
//  AdjustController.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 13/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class AdjustController {

    static var allowPanning : Bool = true
    static var allowRotation : Bool = true
    static var allowScaling : Bool = true
    
    static var node : SCNNode?
    
    private static var isPanning : Bool = false
    private static var isRotating : Bool = false
    private static var isScaling : Bool = false
    
    static func activate(_ node : SCNNode,_ allowPanning : Bool = true, _ allowRotation : Bool = true, _ allowScaling : Bool = true ){
        
        AdjustController.node = node
        
        AdjustController.allowPanning = allowPanning
        AdjustController.allowRotation = allowRotation
        AdjustController.allowScaling = allowScaling
    }
    
    static func deactivate(){
        AdjustController.node = nil
        
        AdjustController.allowPanning = false
        AdjustController.allowRotation = false
        AdjustController.allowScaling = false
    }
    
    static func rotationGestureStart(){
        if !allowRotation {
            return
        }
        
    }
    
    static func rotationGestureUpdate(){
        
    }
    
    static func rotationGestureEnd(){
        
    }
    
    static func panGestureStart(){
        if !allowPanning {
                  return
              }
              
        
    }
    
    static func panGestureUpdate(){
        
        
    }
    
    static func panGestureEnd(){
        
    }
    
    static func scaleGestureStart(){
        if !allowScaling {
                  return
              }
              
    }
    
    static func scaleGestureUpdate(){
        
    }
    
    static func scaleGestureEnd(){
        
    }
}
