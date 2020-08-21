//
//  InteractionSugarAcid.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 18/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SceneKit

class InteractionBeckerSelf : Interaction{
    var beckerActive : Becker?
    var beckerReceiver : Becker?
    
    override init(){
        
        super.init()
        
        self.completitionHandler = {() -> Void in
            self.beckerActive!.state?.enter(StateIdle.self)
            self.beckerReceiver!.state?.enter(StatePositioned.self)
            self.beckerReceiver = nil
        }
    }
    
    override func setTools(_ tools: [Tool]) {
        beckerActive = tools.first as? Becker
        beckerReceiver = tools[1] as? Becker
        self.affectedNode = beckerActive!.node
    }
    
    override func run(){
        if let beckerActive = self.beckerActive, let beckerReceiver = self.beckerReceiver{
            beckerActive.state?.enter(StateActive.self)
            beckerReceiver.state?.enter(StateActive.self)
            
            let start = beckerActive.getPositionRelativeToAnchor(beckerReceiver.getAnchor(.up) + SCNVector3(0,0.1,0), .right)
            let target = start - SCNVector3(0,0.099,0)
            
            var last : CGFloat = 0.0
            let pourAction = SCNAction.customAction(duration: 3.0) { (node, time) in
                let amount = Int( (time - last) * 120)
                print("amount: \(amount)")
                let substance = beckerActive.draw(amount)!
                beckerReceiver.fill(with: substance, volume: amount)
                last = time
            }
            
            self.actionSequence = SCNAction.sequence([SCNAction.move(to: start, duration: 0.5),
                                                      SCNAction.move(to: target, duration: 0.5),
                                                      SCNAction.rotateTo(x: 0, y: 0, z: .pi / 2, duration: 0.7),
                                                      pourAction,
                                                      SCNAction.wait(duration: 0.3),
                                                      SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 0.5),
                                                      SCNAction.move(to: beckerActive.restPoint!.position, duration: 0.5)])
            
            super.run()
        }
        else{
            print("Missing becker reference in InteractionBeckerSelf")
        }
    }
}
