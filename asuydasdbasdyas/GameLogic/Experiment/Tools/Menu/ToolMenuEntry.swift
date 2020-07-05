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
    
    var menu : ToolMenu
    var onTapAction : ((Tool)->Void)?
    
    init (_ menu : ToolMenu,_ onTapAction: ((Tool)->Void)?){
        self.onTapAction = onTapAction
        self.menu = menu
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func hit(_ hitResult: SCNHitTestResult) {
        if let tool = menu.affectedTool{
            onTapAction?(tool)
        }
        else{
            print("No such action can be performed because there is no affected tool.")
        }
    }
}
