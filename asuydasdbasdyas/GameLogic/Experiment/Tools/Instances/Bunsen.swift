//
//  Bunsen.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 16/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class Bunsen : Heater, Stackable{
    
    var fireParticle : SCNNode
    
    override init (_ node : SCNNode, _ displayName : String){
        fireParticle = node.childNode(withName: "fire",recursively: true)!
        fireParticle.isHidden = true
        super.init(node,displayName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        if type(of: otherTool) == BunsenStand.self {
            return true
        }
        if type(of: otherTool) == Becco.self {
                   return true
        }
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        if type(of: otherTool) == BunsenStand.self {
            state?.enter(StatePositioned.self)
            otherTool.state?.enter(StatePositioned.self)
            otherTool.place(getAnchor(.down))
        }
        else if let becco = otherTool as? Becco{
            becco.useWith(self)
        }
    }
    
    override func toggleActive(){
        //print("toggleActive")
        isActive = !isActive
        fireParticle.isHidden = !isActive
    }
    
    override func reset() {
        super.reset()
        if isActive{
            toggleActive()
        }
    }
    
    func toolAddedToStack(_ otherTool: Tool) {
        if let becker = otherTool as? Becker {
            heatedTool = becker
        }
    }
}

