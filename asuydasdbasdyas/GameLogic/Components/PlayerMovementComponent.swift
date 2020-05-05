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
    
    var mass : Float = 1
    var speed : Float = 6
    var isGrounded : Bool = false
    var jumpForce : Float = 0.4

    
    init(_ physicsComponent : PhysicsComponent, _ meshComponent: MeshRendererComponent){
        self.physics = physicsComponent
        self.mesh = meshComponent
        
        self.physics.body.mass = CGFloat(self.mass)
        
        
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
        
        moveDelta(GameManager.getInstance().sceneManager!.touchController!.leftStick!.direction, Float(seconds))
    }
    
    func moveDelta(_ direction: simd_float2, _ deltaTime: Float)
    {
        
        let actualSpeed = isGrounded ? speed : speed * airControlIndex
//        let movement = simd_float3.zero
        let cameraRight = GameManager.getInstance().arCameraTransform!.right
        let cameraForward = GameManager.getInstance().arCameraTransform!.front
        
        let right = cameraRight * direction.x
        let forward = cameraForward * direction.y
        
        
        let direction:Vector3 = Vector3(right + forward)
        direction.y = 0
        if deltaTime > 1.0/60.0 + 0.001 {
            print(deltaTime)
        }
        
        
        mesh.node.look(at:direction.getScnVector3())
        mesh.node.eulerAngles = SCNVector3(0,mesh.node.eulerAngles.y,0)
        
        
        physics.body.applyForce(direction.normalized().getScnVector3() * deltaTime * actualSpeed * 20 * mass,asImpulse: false)
        physics.body.velocity = physics.body.velocity * SCNVector3(0,1,0)
    }
    
    func jump()
    {
        //print("jump")
        if !isGrounded { return }
        
        physics.body.applyForce(SCNVector3(0,jumpForce * mass,0), asImpulse: true)
    }
}
