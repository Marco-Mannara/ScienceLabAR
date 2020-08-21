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

class Becker : Container, Stackable {
    
    private var substanceNode : SCNNode?
    
    override init(_ node :SCNNode, _ displayName: String, _ volumeCapacity : Float){
        super.init(node, displayName, volumeCapacity)
        self.interaction = [:]
        
        interaction!["becker"] = InteractionBeckerSelf()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func fill(with substance : Substance, volume: Int){
        super.fill(with: substance, volume: volume)
        let contentMesh = contentsNode.geometry as! SCNCylinder
        let surface = pow(contentMesh.radius,2) * .pi
        let height = (Double(volume) / 1000000.0) / Double(surface)
        
        contentMesh.height = CGFloat(height)
        contentsNode.position = SCNVector3(height / 2.0 + 0.003,0,0)
    }
    
    override func isCompatible(_ otherTool: Tool) -> Bool {
        if type(of: otherTool) == BunsenStand.self{
            return true
        }
        else if type(of:otherTool) == Becco.self{
            return true
        }
        else if type(of:otherTool) == Becker.self{
            return true
        }
        return false
    }
    override func useWith(_ otherTool: Tool) {
        if type(of: otherTool) == BunsenStand.self{
            
        }
        else if let _ = otherTool as? Becker{
            let i = interaction!["becker"]!
            i.setTools([otherTool,self])
            i.run()
            GameManager.getInstance().sceneManager.currentExperiment?.goals?.onToolAction(self, otherTool)
        }
        else if let becco = otherTool as? Becco{
            becco.useWith(self)
        }
    }
    func toolAddedToStack(_ otherTool: Tool) {
    }
}
