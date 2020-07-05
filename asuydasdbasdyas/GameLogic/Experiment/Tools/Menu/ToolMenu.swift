//
//  ToolMenu.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 14/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit
import GameplayKit

class ToolMenu : GKEntity{
    var entries : [SCNNode]
    var entryEntities : [ToolMenuEntry]
    
    var affectedTool : Tool?
    var rollbackState : ToolState.Type
    
    private var experiment : Experiment
    private var node : SCNNode
    private var menuWidth : Double = 0.09
    private var entrySize : Double = 0.03
    private var entryPadding : Double = 0.02
    
    init(_ experiment : Experiment, _ rollbackState : ToolState.Type){
        self.experiment = experiment
        self.rollbackState = rollbackState
        
        self.node = SCNNode()
        self.entries = []
        self.entryEntities = []
        
        super.init()
        
        let plane = SCNPlane(width: CGFloat(menuWidth), height: 1)
        
        node = SCNNode()
        node.name = "tool_menu"
        node.geometry = plane
        node.geometry?.materials.first?.diffuse.contents = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0.25)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func spawn(){
        let entryNumber = entries.count
        let planeHeight1 = Double(entryNumber) * entrySize
        let planeHeight2 = entryPadding * Double(entryNumber + 1)
        let planeHeight = planeHeight2 + planeHeight1
        let planeTop = planeHeight / 2 - entryPadding

        var last = 0
        
        for entry in entries{
            entry.position = SCNVector3(0, planeTop - Double(last) * (entrySize + entryPadding) - entrySize / 2,0)
            last += 1
        }
        
        let plane = node.geometry as! SCNPlane
        plane.height = CGFloat(planeHeight)
        node.isHidden = true
        node.constraints = [SCNBillboardConstraint()]
        
        experiment.sceneRoot!.addChildNode(node)
    }
    
    func addEntry(_ meshNode: SCNNode,_ action :((Tool) -> Void)?){
        let toolMenuEntry = ToolMenuEntry(self,action)
        
        let menuEntryNode = SCNNode()
        
        menuEntryNode.name = "menu_entry"
        menuEntryNode.entity = toolMenuEntry
        menuEntryNode.geometry = SCNBox(width: CGFloat(entrySize), height: CGFloat(entrySize), length: CGFloat(entrySize), chamferRadius: 0)
        menuEntryNode.geometry?.materials.first?.diffuse.contents = UIColor(displayP3Red: 0, green: 0, blue: 0, alpha: 0)
        
        let meshNodeBounds = meshNode.boundingBox.max - meshNode.boundingBox.min
        let scaleFactor = meshNode.scale.x * 0.03 / meshNodeBounds.x
        
        meshNode.scale =  meshNode.scale * scaleFactor
        
        menuEntryNode.addChildNode(meshNode)
        node.addChildNode(menuEntryNode)
        
        entries.append(menuEntryNode)
        entryEntities.append(toolMenuEntry)
    }
    
    func display(_ tool: Tool){
        affectedTool?.state?.enter(rollbackState)
        
        affectedTool = tool
        
        node.isHidden = false
        node.position = tool.getAnchor(.upRight) + SCNVector3(0.05,0.05,0)
    }
    
    func hide(){
        node.isHidden = true
        affectedTool = nil
    }
}

