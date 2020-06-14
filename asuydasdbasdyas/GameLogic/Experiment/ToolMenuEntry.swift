//
//  ToolMenuEntry.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 14/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit
import GameplayKit

class ToolMenuEntry : GKEntity, EntityHitProtocol{
    
    var toolMenu : ToolMenu
    
    init (_ toolMenu : ToolMenu){
        self.toolMenu = toolMenu
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
    }
}
