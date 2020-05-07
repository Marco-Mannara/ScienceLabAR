//
//  ActionTest.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 07/05/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SceneKit

class ActionTest{
    
    var node : SCNNode
    
    init(_ node : SCNNode){
        self.node = node
    }
    
    func executeAction(){
        node.runAction(SCNAction.scale(by: 2, duration: 2.0)) {
            print("Action Complete")
        }
    }
}
