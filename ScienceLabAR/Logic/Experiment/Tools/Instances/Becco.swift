//
//  Becco.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 28/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit


class Becco : Container{
    
    override init(_ node: SCNNode, _ displayName: String, _ volumeCapacity: Float) {
        super.init(node, displayName, volumeCapacity)
        interaction = [:]
        interaction?["bunsen"] = InteractionBeccoBunsen(self)
        interaction?["piattino"] = InteractionBeccoPiattino(self)
        interaction?["becker"] = InteractionBeccoBecker(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        if type(of: otherTool) == Container.self{
           return true
        }
        else if type(of: otherTool) == Bunsen.self{
            return true
        }
        return false
    }
    
    override func useWith(_ otherTool: Tool) {
        if let _ = otherTool as? Piattino{
            let i = interaction!["piattino"]!
            i.setTools([otherTool])
            i.run()
            GameManager.getInstance().sceneManager!.currentExperiment?.goals?.onToolAction(otherTool,self)
        }
        else if let _ = otherTool as? Bunsen{
            let i = interaction!["bunsen"]!
            i.setTools([otherTool])
            i.run()
            GameManager.getInstance().sceneManager!.currentExperiment?.goals?.onToolAction(otherTool,self)
        }
        else if let _ = otherTool as? Becker{
            let i = interaction!["becker"]!
            i.setTools([otherTool])
            i.run()
            GameManager.getInstance().sceneManager!.currentExperiment?.goals?.onToolAction(otherTool,self)
        }
    }
    
    override func fill(with substance: Substance, volume: Float) {
        super.fill(with: substance,volume: volume)
    }
}
