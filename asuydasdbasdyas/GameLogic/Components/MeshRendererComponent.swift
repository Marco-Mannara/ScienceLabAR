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
    
    
    static func Box() -> MeshRendererComponent
    {
        return MeshRendererComponent.Box(0.01, UIColor.red)
    }
    
    static func Box(_ color: UIColor) -> MeshRendererComponent{
        MeshRendererComponent.Box(0.01, color)
    }
    
    static func Box(_ size : Float,_ color: UIColor) -> MeshRendererComponent{
        let dimension = CGFloat(size)
        let geom = SCNBox(width: dimension, height: dimension, length: dimension, chamferRadius: dimension / 10)
        geom.materials.first?.diffuse.contents = color
        return MeshRendererComponent(geom)
    }
}
