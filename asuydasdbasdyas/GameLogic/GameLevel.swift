//
//  GameLevel.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 27/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SceneKit

class GameLevel{
    
    private var chunks : [SCNNode]
    var spawnPoint : simd_float3
//    private var endLevelTrigger :
    
    init(_ scene : SCNScene)
    {
        spawnPoint = scene.rootNode.childNode(withName: "spawn_point", recursively: false)?.simdPosition ?? simd_float3(0,0,0)
        chunks = scene.rootNode.childNodes(passingTest: {(node, pointer) -> Bool in
            let name = node.name ?? ""
            return name.hasPrefix("spawn_point")
        })
        
        
        print(spawnPoint)
        print(chunks)
    }
    
    convenience init(_ sceneName: String){
        self.init(SCNScene(named: sceneName)!)
    }
}


