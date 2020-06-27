//
//  Becker.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 11/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit
import SpriteKit

class Becker : Container {
    
    private var substanceNode : SCNNode?
    
    override init(_ node :SCNNode, _ displayName: String, _ volumeCapacity : Float){
        super.init(node, displayName, volumeCapacity)
        
    }
    
    init(_ node : SCNNode, _ displayName: String, _ volumeCapacity : Float, filledWith substance: Substance){
        super.init(node, displayName, volumeCapacity)
        fill(with: substance)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func fill(with substance : Substance){
        let worldRadius = meshNode.boundingBox.max.x - meshNode.boundingBox.min.x  - 0.006
        let localRadius = worldRadius * meshNode.scale.x / 2
        
        if substanceNode == nil {
            substanceNode = SCNNode()
            substanceNode?.name = "substance"
            substanceNode?.geometry = SCNCylinder(radius: CGFloat(localRadius), height: 1)
            node.addChildNode(substanceNode!)
        }
        let height = substance.volumeInLiters / Double(2 * .pi * worldRadius)
        let meshHeight = (meshNode.boundingBox.max.y - meshNode.boundingBox.min.y) * meshNode.scale.y
        substanceNode?.scale = SCNVector3(1,height,1)
        substanceNode?.position = SCNVector3(0,(height - Double(meshHeight)) / 2.0 + 0.04,0)
        //substanceNode?.geometry?.materials.first?.diffuse.contents = UIColor.red
        
        contents.append(substance)
    }
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
       if type(of: otherTool) == BunsenStand.self{
           return true
       }
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        super.useWith(otherTool)
        
        if type(of: otherTool) == BunsenStand.self{
            
        }
    }
}
