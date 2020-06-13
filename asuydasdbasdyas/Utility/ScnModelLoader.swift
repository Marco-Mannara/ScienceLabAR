//
//  ScnModelLoader.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 13/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class ScnModelLoader{
    
    
    static func loadModel(_ name: String) -> SCNNode?{
        let scene = SCNScene(named: name)
        let node = scene?.rootNode.childNode(withName: name, recursively: false)
        return node
    }
    
}
