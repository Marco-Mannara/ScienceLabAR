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
    
    var positionedTool : Tool?
    
    var experiment : Experiment
    var node : SCNNode
    
    init(_ experiment : Experiment, _ node: SCNNode){
        self.experiment = experiment
        self.node = node

        super.init()
        
        node.entity = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
        print("hit workposition")
        if let selTool = experiment.selection?.toolSelected{
            selTool.state?.enter(StatePositioned.self)
        }
        /*else if let selTool = experiment.selection?.toolSelectedB{
            selTool.state?.enter(StatePositioned.self)
        }*/
    }
    
    func place(_ tool : Tool){
        //experiment.hint?.disableHighlight()
        if positionedTool == nil{
            positionedTool = tool
            tool.place(node.position)
        }
    }
}
