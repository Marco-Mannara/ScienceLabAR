//
//  PhysicsComponent.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 17/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit
import GameplayKit
import SceneKit

class PhysicsComponent: GKComponent {
    
    var node : SCNNode
    var body : SCNPhysicsBody
    
    init(_ physicsShape : SCNPhysicsShape){
        self.node = SCNNode()
        self.body = SCNPhysicsBody(type: .dynamic, shape: physicsShape)
        self.node.physicsBody = self.body
        
        super.init()
    }
    
    init(_ physicsShape : SCNPhysicsShape, _ isKinematic : Bool){
        self.node = SCNNode()
        if(!isKinematic){
            self.body = SCNPhysicsBody(type: .dynamic, shape: physicsShape)
        }
        else{
            self.body = SCNPhysicsBody(type: .kinematic, shape: physicsShape)
        }
        self.node.physicsBody = self.body
        
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
