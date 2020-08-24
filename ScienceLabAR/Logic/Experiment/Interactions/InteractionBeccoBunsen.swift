//
//  EventSubstanceBurning.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 02/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//


import Foundation
import SceneKit

class InteractionBeccoBunsen : Interaction{
    
    var becco : Becco
    var bunsen : Bunsen?
    
    init(_ becco : Becco){
        self.becco = becco
        
        super.init()
    
        self.affectedNode = becco.node

        self.completitionHandler = {() -> Void in
            self.bunsen!.state?.enter(StatePositioned.self)
            self.becco.state?.enter(StateIdle.self)
            self.bunsen = nil
        }
    }
    
    override func setTools(_ tools: [Tool]) {
        let bunsen = tools.first as! Bunsen
        self.bunsen = bunsen
    }
    
    override func run(){
        becco.state?.enter(StateActive.self)
        bunsen!.state?.enter(StateActive.self)
        
        let start = becco.getPositionRelativeToAnchor(bunsen!.getAnchor(.up) + SCNVector3(0,0.1,0), .right)
        let target = start - SCNVector3(0,0.07,0)
        
        let flameColorToSubstance = SCNAction.customAction(duration: 0, action: { (node, delta) in
            if let substance = self.becco.contents.first?.key{
                self.bunsen!.fireParticle.particleSystems?.first?.particleColor = substance.flameColor
                //self.becco.clearContents()
            }
        })
        
        let flameColorToNormal = SCNAction.customAction(duration: 0, action: { (node, delta) in
            self.bunsen!.fireParticle.particleSystems?.first?.particleColor = UIColor(named: "bunsenFlameColor")!
        })
        
        self.actionSequence = SCNAction.sequence([SCNAction.move(to: start, duration: 1),
                                                  SCNAction.move(to: target, duration: 1),
                                                  flameColorToSubstance,
                                                  SCNAction.wait(duration: 5),
                                                  flameColorToNormal,
                                                  SCNAction.move(to: becco.restPoint!.position, duration: 1)])
        
        super.run()
    }
}
