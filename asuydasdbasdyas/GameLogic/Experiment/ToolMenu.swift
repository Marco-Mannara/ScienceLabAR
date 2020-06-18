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
    var entries : [ToolMenuEntry]
    var affectedTool : Tool?
    
    private var experiment : Experiment
    private var node : SCNNode
    
    init(_ experiment : Experiment){
        self.experiment = experiment
        self.node = SCNNode()
        entries = []
        super.init()
        setup()
        //GameManager.getInstance().updateManager?.subscribe(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /*
    override func update(deltaTime seconds: TimeInterval) {
        if !node.isHidden{
            if let position = GameManager.getInstance().arCameraTransform?.getPosition(){
                node.simdLook(at: position)
            }
        }
    }*/
    
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
        node.constraints = [SCNBillboardConstraint()]
        //menuNode.pivot = SCNMatrix4Translate(menuNode.pivot, 0, 0, 0)
        
        experiment.sceneRoot.addChildNode(node)
    }
    
    func display(_ tool: Tool){
        affectedTool?.state?.enter(StateIdle.self)
        
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
        if let tool = affectedTool{
            if tool.state?.enter(StatePickedUp.self) ?? false{
                hide()
            }
            /*if experiment.selection.selectTool(tool){
                hide()
            }*/
        }
        else{
            print("but affected tool is nil")
        }
    }
    
    func cancelEntryPressed(){
        print("pressed cancel")
        affectedTool?.state?.enter(StateIdle.self)
    }
}

