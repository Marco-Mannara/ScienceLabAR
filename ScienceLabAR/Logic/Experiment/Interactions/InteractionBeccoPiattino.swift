//
//  InteractionBeccoPiattino.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 02/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import GameplayKit

class InteractionBeccoPiattino : Interaction{
    var becco : Becco
    var piattino : Piattino?
    
    init(_ becco : Becco){
        self.becco = becco
        
        super.init()
        
        self.affectedNode = becco.node
        
        
        self.completitionHandler = {() -> Void in
            self.piattino!.state?.enter(StatePositioned.self)
            self.becco.state?.enter(StateIdle.self)
            self.piattino = nil
        }
    }
    
    override func setTools(_ tools: [Tool]) {
        let piattino = tools.first as! Piattino
        self.piattino = piattino
    }
    
    override func run(){
        
        
        becco.state?.enter(StateActive.self)
        piattino!.state?.enter(StateActive.self)
        
        let start = becco.getPositionRelativeToAnchor(piattino!.getAnchor(.up) + SCNVector3(0,0.1,0), .right)
        let target = start - SCNVector3(0,0.099,0)
        
        let substancePickup = SCNAction.customAction(duration: 0) { (node, delta) in
            if let substance = self.piattino?.draw(3){
                self.becco.fill(with: substance, volume: 3)
            }
        }
        
        self.actionSequence = SCNAction.sequence([SCNAction.move(to: start, duration: 0.5),
                                                  SCNAction.move(to: target, duration: 0.5),
                                                  substancePickup,
                                                  SCNAction.wait(duration: 0.3),
                                                  SCNAction.move(to: becco.restPoint!.position, duration: 0.5)])
        
        super.run()
    }
}
