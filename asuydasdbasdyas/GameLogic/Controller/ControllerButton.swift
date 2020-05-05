//
//  ControllerButton.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 21/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import GameplayKit
import SpriteKit

class ControllerButton {
    
    var scene : SKScene
    var node: SKSpriteNode
    
    var action: (() -> Void)?
    
    
    init(_ scene:SKScene, _ nodeName: String){
        self.scene = scene
        self.node = scene.childNode(withName: nodeName) as! SKSpriteNode
        //self.node.isUserInteractionEnabled = true
    }

    func checkHit(_ point: CGPoint) -> Bool{
        let position = CGPoint.screenToSpriteSceneCoordinates(point)
        return position.x >= node.frame.minX && position.x <= node.frame.maxX &&
            position.y >= node.frame.minY && position.y <= node.frame.maxY
    }
}
