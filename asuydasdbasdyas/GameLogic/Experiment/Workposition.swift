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
    
    var experiment : Experiment
    var node : SCNNode
    
    init(_ experiment : Experiment, _ node: SCNNode){
        self.experiment = experiment
        self.node = node
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
    }
}
