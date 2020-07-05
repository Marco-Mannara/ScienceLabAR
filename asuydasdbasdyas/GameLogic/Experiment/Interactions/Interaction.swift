//
//  Event.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 02/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//


import Foundation
import SceneKit

class Interaction {
    var affectedNode : SCNNode?
    var actionSequence : SCNAction?
    var completitionHandler : (() -> Void)?
    
    init(){}
    
    func run(_ otherTool: Tool){
        if let affectedNode = affectedNode, let actionSequence = actionSequence{
            affectedNode.runAction(actionSequence, forKey: "event", completionHandler: completitionHandler)
            self.actionSequence = nil
            self.affectedNode = nil
            completitionHandler = nil
        }
    }
    
    func stop(){
        affectedNode?.removeAction(forKey: "event")
    }
}
