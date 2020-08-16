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
    private var leftStack : ToolStack
    private var rightStack : ToolStack
    
    var experiment : Experiment
    var node : SCNNode
    var enabled : Bool = true
    
    init(_ experiment : Experiment, _ node: SCNNode){
        self.experiment = experiment
        self.node = node
        self.leftStack = ToolStack()
        self.rightStack = ToolStack()
                
        super.init()
        
        node.entity = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
        //print("hit workposition")
        if let selTool = experiment.selection?.selectedTool{
            if leftStack.isEmpty() && selTool.self is Stackable{
                selTool.state?.enter(StatePositioned.self)
            }
        }
    }
    
    func place(_ tool : Tool){
        if leftStack.isEmpty(){
            tool.place(node.position)
            node.isHidden = true
        }
        leftStack.addTool(tool)
    }
    
    func remove( _ tool : Tool){
        leftStack.removeTool(tool)
        
        if leftStack.isEmpty(){
            node.isHidden = false
        }
        else{
            print("removed item but stack is not empty")
        }
    }
    
    func getCompatibleTools(for tool: Tool) -> [Tool]{
        var leftCompatibleTools = leftStack.getCompatibleTools(for: tool)
        let rightCompatibleTools = rightStack.getCompatibleTools(for: tool)
        
        leftCompatibleTools.append(contentsOf: rightCompatibleTools)
        return leftCompatibleTools
    }
}
