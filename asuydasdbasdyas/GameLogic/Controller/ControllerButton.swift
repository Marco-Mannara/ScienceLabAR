//
//  ControllerButton.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 21/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import GameplayKit

class ControllerButton {
    
    var scene : SKScene
    var node: SKNode
    var size: simd_float2 = simd_float2.zero
    var position: simd_float2 = simd_float2.zero
    
    var action: (() -> Void)?
    
    private lazy var bounds : simd_float4 = simd_float4(position.x - size.x / 2,
                                                        position.y - size.y / 2,
                                                        position.x + size.x / 2,
                                                        position.y + size.y / 2)
    
    init(_ scene:SKScene, _ nodeName: String){
        self.scene = scene
        self.node = scene.childNode(withName: nodeName)!
    }
    
    convenience init(_ scene: SKScene, _ nodeName : String, _ positionFromScreenCenter : CGPoint)
    {
        self.init(scene,nodeName)
        self.node.position = positionFromScreenCenter
    }
    
    
    func checkHit(_ point: simd_float2) -> Bool{
        return point.x >= bounds.x && point.x <= bounds.z && point.y >= bounds.y && point.y <= bounds.w
    }
}
