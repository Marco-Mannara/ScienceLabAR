
//
//  Spatula.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 26/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SceneKit


class Spatula : Container{
    
    private var contentNode: SCNNode
    
    override init(_ node: SCNNode, _ displayName: String, _ volumeCapacity: Float){
        contentNode = node.childNode(withName: "contents", recursively: false)!
        contentNode.isHidden = true
        super.init(node, displayName, volumeCapacity)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        if type(of: otherTool) == Becker.self{
            return true
        }
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        if type(of: otherTool) == Becker.self {
            
        }
    }
}

