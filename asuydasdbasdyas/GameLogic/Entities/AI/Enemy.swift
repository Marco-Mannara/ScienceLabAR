//
//  Enemy.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 22/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SceneKit
import GameplayKit


class Enemy : GKEntity, GKAgentDelegate
{
    let agent: GKAgent2D
    let goal : GKGoal
    let target : GKAgent2D
    
    var mesh : MeshRendererComponent?
    var physics : PhysicsComponent?
    
    var mainNode : SCNNode
    
    //var state : GKStateMachine
        
    init(_ playerAgent : GKAgent2D){
        
        self.agent = GKAgent2D()
        self.target = playerAgent
        goal = GKGoal(toSeekAgent: playerAgent)
        agent.behavior = GKBehavior(goal: goal, weight: 1.0)
        agent.mass = 0.00001
        agent.maxSpeed = 3
        agent.maxAcceleration = 5
        agent.radius = 0.25
    
        self.mainNode = SCNNode()

        //self.state = GKStateMachine()
        
        super.init()
        
        agent.delegate = self
        
        self.mesh = MeshRendererComponent.Box(UIColor.green)
        self.physics = PhysicsComponent(SCNPhysicsShape(geometry: mesh!.node.geometry!),false)
        
        self.physics?.body.angularVelocityFactor = SCNVector3(0,0,0)
        
        self.mainNode = physics!.node
        self.mainNode.addChildNode(mesh!.node)
    }
    
    func spawn(_ scene: SCNScene, _ position: simd_float3){
        scene.rootNode.addChildNode(mainNode)
        
        //mainNode.simdPosition = position
        agent.position = simd_float2(position.x, position.z)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func update(deltaTime seconds: TimeInterval) {
        agent.update(deltaTime: seconds)
        //print(agent.position)
    }
    
    func agentDidUpdate(_ agent: GKAgent) {
        if let agent = agent as? GKAgent2D{
            let agentPosition = simd_float3(agent.position.x, 0.0, agent.position.y)
            physics?.node.simdPosition = agentPosition
            mesh?.node.eulerAngles = SCNVector3(0, agent.rotation ,0)
            
            if agentPosition.distance(simd_float3(target.position.x, 0, target.position.y)) <= 0.2{
                agent.behavior?.setWeight(0.0, for: goal)
                agent.speed = 0
            }
            else{
                agent.behavior?.setWeight(1.0, for: goal)
            }
        }
    }
    
    func agentWillUpdate(_ agent: GKAgent)
    {
        /*
        if let agent = agent as? GKAgent2D{
            agent.position = simd_float2(mainNode.presentation.position.x, mainNode.presentation.position.y)
        }*/
    }
}
