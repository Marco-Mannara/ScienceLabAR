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
    
    func setTools(_ tools : [Tool]){}
    
    func run(){
        if let affectedNode = affectedNode, let actionSequence = actionSequence{
            affectedNode.runAction(actionSequence, forKey: "interaction", completionHandler: completitionHandler)
        }
    }
    
    func stop(){
        affectedNode?.removeAction(forKey: "interaction")
    }
}
