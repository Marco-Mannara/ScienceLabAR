//
//  InteractionBeccoBecker.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 15/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class InteractionBeccoBecker : Interaction{
    private var becco : Becco
    var becker : Becker?
    
    init(_ becco : Becco){
        self.becco = becco
        super.init()
        
        self.affectedNode = becco.node
        self.completitionHandler = {() -> Void in
            self.becco.state?.enter(StateIdle.self)
            self.becker?.state?.enter(StatePositioned.self)
            self.becker = nil
        }
    }
    
    override func setTools(_ tools : [Tool]){
        let becker = tools.first as! Becker
        self.becker = becker
    }
    
    override func run() {
        if let becker = self.becker{
            becco.state?.enter(StateActive.self)
            becker.state?.enter(StateActive.self)
            let start = becker.getAnchor(.up) + SCNVector3(0,0.02,0)
            let target = becker.getAnchor(.down) + SCNVector3(0,0.1,0)
            
            let substancePickup = SCNAction.customAction(duration: 0) { (node, delta) in
                if let substance = self.becker?.draw(3){
                    let substanceName = substance.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
                    if substanceName == "acidosolforico"{
                        self.becco.clearContents()
                    }
                    else{
                        self.becco.fill(with: substance, volume: 3)
                    }
                }
            }
            
            self.actionSequence = SCNAction.sequence([SCNAction.move(to: start, duration: 0.5),
                                                      SCNAction.rotateTo(x: 0, y: 0, z: .pi / 2, duration: 0.5),
                                                      SCNAction.move(to: target, duration: 0.5),
                                                      substancePickup,
                                                      SCNAction.wait(duration: 0.3),
                                                      SCNAction.move(to: start, duration: 0.5),
                                                      SCNAction.rotateTo(x: 0, y: 0, z: 0, duration: 0.5),
                                                      SCNAction.move(to: becco.restPoint!.position, duration: 0.5)])
            
            super.run()
        }
        else{
            print("Missing reference to becker in InteractionBeccoBecker")
        }
    }
}
