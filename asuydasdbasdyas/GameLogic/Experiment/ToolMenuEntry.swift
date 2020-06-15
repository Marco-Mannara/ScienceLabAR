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
    var onTapAction : (()->Void)?
    
    init (_ toolMenu : ToolMenu, _ onTapAction: (()->Void)?){
        self.toolMenu = toolMenu
        self.onTapAction = onTapAction
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
        print("hit menu entry")
        onTapAction?()
    }
}
