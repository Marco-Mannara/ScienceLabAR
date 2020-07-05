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
        interaction?["bunsen"] = InteractionSubstanceBurning(self)
        interaction?["piattino"] = InteractionBeccoPiattino(self)
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
        if let piattino = otherTool as? Piattino{
            interaction?["piattino"]!.run(piattino)
        }
        else if let bunsen = otherTool as? Bunsen{
            interaction?["bunsen"]!.run(bunsen)
        }
    }
    
    override func fill(with substance: Substance, volume: Int) {
        super.fill(with: substance,volume: volume)
    }
}
