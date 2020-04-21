//
//  PlayerMovementComponent.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 18/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit
import GameplayKit
import SceneKit

class PlayerMovementComponent: GKComponent
{
    var physics : PhysicsComponent
    var mesh : MeshRendererComponent
    
    var speed : Float = 10
    var isGrounded : Bool = false
    
    init(_ physicsComponent : PhysicsComponent, _ meshComponent: MeshRendererComponent){
        self.physics = physicsComponent
        self.mesh = meshComponent
        super.init()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval)
    {
        if(physics.body.velocity.y >= 0.01 || physics.body.velocity.y <= -0.01){
            isGrounded = false
        }
        else{
            isGrounded = true
        }
        
        if isGrounded {
            moveDelta(GameViewController.LeftStick!.direction, Float(seconds))
            physics.body.velocity = SCNVector3(0,0,0)
        }
    }
    
    func moveDelta(_ direction: simd_float2, _ deltaTime: Float)
    {
//        let movement = simd_float3.zero
        let right = Vector3(GameViewController.SceneCamera!.simdWorldRight * direction.x * deltaTime * speed * 1000)
        let forward = Vector3(-GameViewController.SceneCamera!.simdWorldFront * direction.y * deltaTime * speed * 1000)
        
        right.y = 0
        forward.y = 0
        
//        physics.node.simdPosition += (forward + right).getSimdFloat3()
        let direction:Vector3 = right + forward
        
        mesh.node.look(at:direction.getScnVector3())
        physics.body.applyForce(direction.getScnVector3(),asImpulse: false)
    }
    
    func jump()
    {
//        print("jump")
        if !isGrounded { return }
        
        physics.body.applyForce(SCNVector3(0,200,0), asImpulse: false)
    }
}
