//
//  ToolMenu.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 14/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class ToolMenu {
    var entries : [ToolMenuEntry]
    var affectedTool : Tool?
    
    private var experiment : Experiment
    private var node : SCNNode
    
    
    init(_ experiment : Experiment){
        self.experiment = experiment
        self.node = SCNNode()
        entries = []
        
        setup()
    }
    
    private func setup(){
        //let handEntryNode = ScnModelLoader.loadModel("interaction_symbols/symbols", "hand_symbol")!
        //let cancelEntryNode = ScnModelLoader.loadModel("interaction_symbols/symbols", "cancel_symbol")!
        node = ScnModelLoader.loadModel("tool_menu")!

        let handEntryNode = node.childNode(withName: "hand_symbol", recursively: true)!
        let cancelEntryNode = node.childNode(withName: "cancel_symbol", recursively: true)!
        
        let handEntryEntity = ToolMenuEntry(self, {()-> Void in
            self.handEntryPressed()
        })
        let cancelEntryEntity = ToolMenuEntry(self, {()-> Void in
            self.cancelEntryPressed()
        })
        
        entries.append(handEntryEntity)
        entries.append(cancelEntryEntity)
        
        handEntryNode.entity = handEntryEntity
        cancelEntryNode.entity = cancelEntryEntity
        
        node.isHidden = true
        print(node.pivot)
        //menuNode.pivot = SCNMatrix4Translate(menuNode.pivot, 0, 0, 0)
        
        experiment.sceneRoot.addChildNode(node)
    }
    
    func display(_ tool: Tool){
        affectedTool = tool
        node.isHidden = false
        node.position = tool.getAnchorPosition(.upRight)
    }
    
    func hide(){
        node.isHidden = true
        affectedTool = nil
    }
    
    func handEntryPressed(){
        print("pressed hand")
    }
    
    func cancelEntryPressed(){
        print("pressed cancel")
        experiment.deselectTool(affectedTool!)
    }
}

