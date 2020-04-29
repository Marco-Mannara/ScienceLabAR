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
    var airControlIndex : Float = 0.7
    
    var speed : Float = 6
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
        if(physics.body.velocity.y >= 0.001 || physics.body.velocity.y <= -0.001){
            isGrounded = false
        }
        else{
            isGrounded = true
        }
        
        moveDelta(GameManager.sceneManager!.touchController!.leftStick!.direction, Float(seconds))
    }
    
    func moveDelta(_ direction: simd_float2, _ deltaTime: Float)
    {
        
        let actualSpeed = isGrounded ? speed : speed * airControlIndex
//        let movement = simd_float3.zero
        let right = Vector3(GameManager.arCameraTransform?.right ?? simd_float3.zero * direction.x * deltaTime * actualSpeed * 1000)
        let forward = Vector3(GameManager.arCameraTransform?.front ?? simd_float3.zero * direction.y * deltaTime * actualSpeed * 1000)
        
        right.y = 0
        forward.y = 0
        
//        physics.node.simdPosition += (forward + right).getSimdFloat3()
        let direction:Vector3 = right + forward
        
        mesh.node.look(at:direction.getScnVector3())
        physics.body.applyForce(direction.getScnVector3(),asImpulse: false)
        physics.body.velocity = physics.body.velocity * SCNVector3(0,1,0)
    }
    
    func jump()
    {
//        print("jump")
        if !isGrounded { return }
        
        physics.body.applyForce(SCNVector3(0,200,0), asImpulse: false)
    }
}
