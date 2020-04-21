//
//  MeshRendererComponent.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 13/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit
import GameplayKit
import SceneKit

class MeshRendererComponent: GKComponent {
    
    var node : SCNNode
    
    init(_ geometry: SCNGeometry){
        self.node = SCNNode(geometry: geometry)
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
