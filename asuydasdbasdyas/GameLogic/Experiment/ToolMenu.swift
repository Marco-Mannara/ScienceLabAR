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
    var entries : [SCNNode]
    var affectedTool : Tool
    
    private var experiment : Experiment
    private var containerNode : SCNNode
    
    
    init(_ experiment : Experiment){
        self.experiment = experiment
        self.containerNode = SCNNode()
        entries = []
        
        setup()
    }
    
    private func setup(){
        let handEntryNode = ScnModelLoader.loadModel("interaction_symbols/symbols", "hand_symbol")
        let cancelEntryNode = ScnModelLoader.loadModel("interaction_symbols/symbols", "cancel_symbol")
        
        entries.append(handEntryNode!)
        entries.append(cancelEntryNode!)
        
        for entry in entries{
            containerNode.addChildNode(entry)
            entry.entity = 
        }
        
        containerNode.isHidden = true
        experiment.sceneRoot.addChildNode(containerNode)
    }
    
    func display(_ tool: Tool){
        
    }
}

