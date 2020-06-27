//
//  Piattino.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 26/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class Piattino : Container{
    
    private var contentsNode : SCNNode
    
    override init(_ node: SCNNode, _ displayName: String, _ volumeCapacity: Float) {
        contentsNode = node.childNode(withName: "contents", recursively: true)!
        contentsNode.isHidden = true
        super.init(node,displayName,Float(volumeCapacity))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        
    }
    
    override func fill(with substance: Substance) {
        contentsNode.isHidden = false
    }
    
    override func draw() -> Substance? {
        return nil
    }
}
