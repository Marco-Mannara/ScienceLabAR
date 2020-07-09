//
//  ScnModelLoader.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 13/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class NodeLoader{
    
    static func loadModel(_ sceneName: String, _ nodeName : String? = nil) -> SCNNode?{
        let scene = SCNScene(named: "art.scnassets/" + sceneName + ".scn")
        
        if let nName = nodeName{
            let node = scene?.rootNode.childNode(withName: nName, recursively: false)
            return node
        }
        else
        {
            let node = scene?.rootNode.childNode(withName: sceneName, recursively: false)
            return node
        }
    }
}
