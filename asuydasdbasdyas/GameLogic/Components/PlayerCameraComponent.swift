//
//  PlayerCameraComponent.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 19/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit
import GameplayKit
import SceneKit


class PlayerCameraComponent: GKComponent {
    var cameraNode : SCNNode
    var camera : SCNCamera
    
    init(_ cameraNode : SCNNode){
        self.cameraNode = cameraNode
        camera = cameraNode.camera!
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
