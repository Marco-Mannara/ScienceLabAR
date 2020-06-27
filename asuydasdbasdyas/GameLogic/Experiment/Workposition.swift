//
//  Workposition.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 15/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import GameplayKit
import SceneKit


class WorkPosition : GKEntity, EntityHitProtocol{
    
    
    var stack : ToolStack
    
    var experiment : Experiment
    var node : SCNNode
    var enabled : Bool = true
    
    init(_ experiment : Experiment, _ node: SCNNode){
        self.experiment = experiment
        self.node = node
        self.stack = ToolStack()
                
        super.init()
        
        node.entity = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
        //print("hit workposition")
        if let selTool = experiment.selection?.toolSelected{
            if stack.isEmpty(){
                selTool.state?.enter(StatePositioned.self)
            }
        }
    }
    
    func place(_ tool : Tool){
        //experiment.hint?.disableHighlight()
        if stack.isEmpty(){
            tool.place(node.position)
            node.isHidden = true
        }
        stack.addTool(tool)
    }
    
    func remove( _ tool : Tool){
        stack.removeTool(tool)
        if stack.isEmpty(){
            node.isHidden = false
        }
    }
}
