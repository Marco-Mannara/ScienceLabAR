//
//  ProgrammablePlatform.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 07/05/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SceneKit
import SpriteKit
import GameplayKit

class ProgrammablePlatform : GKEntity{
    
    
    var startingPoint : simd_int3 = simd_int3.zero
    var goalPoint : simd_int3 = simd_int3.zero
    
    var actionSequence : [SCNAction]
    var node : SCNNode?
    
    private var lastIndex : Int = 0
    private var position : simd_int3 = simd_int3.zero
    
    init(_ startingPoint : simd_int3, _ goalPoint : simd_int3){
        self.startingPoint = startingPoint
        self.goalPoint = goalPoint
        self.actionSequence = []
        super.init()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func executeNext(){
        if lastIndex < actionSequence.count{
            let action = actionSequence[lastIndex]
            node?.runAction(action) {
                self.executeNext()
            }
            lastIndex += 1
        }
    }
    
    func addAction(_ action: SCNAction){
        actionSequence.append(action)
    }
    
    func addActions(_ actions: [SCNAction]){
        actionSequence.append(contentsOf: actions)
    }
    
    func startExecution( _ timeBetweenAction : Float)
    {
        executeNext()
    }
    
    func stopExecution(){
        
    }
    
    func reset(){
        stopExecution()
        position = startingPoint
    }
}


