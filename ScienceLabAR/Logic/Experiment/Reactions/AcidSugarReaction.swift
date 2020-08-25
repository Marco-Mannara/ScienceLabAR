//
//  AcidSugarReaction.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 24/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit
import Accelerate

class AcidSugarReaction : Reaction{
    
    private var smokeParticle : SCNNode
    
    private static var referenceToSelf : AcidSugarReaction? = nil
    static var instance : AcidSugarReaction {
        get{
            if referenceToSelf == nil{
                referenceToSelf = AcidSugarReaction()
            }
            return referenceToSelf!
        }
    }
    
    private override init(){
        self.smokeParticle = NodeLoader.loadModel("particles/smoke_particle", "smoke_particle")!
        
        super.init()
        self.substanceA = "acidosolforico"
        self.substanceB = "saccarosio"
        self.resultSubstance = SubstanceDictionary.getSubstance("Carbonio")
        
        let colorTransition0 = SCNAction.customAction(duration: 3) { (node, time) in
            let rgbValues = vDSP.linearInterpolate([1.0,1.0,1.0], [0.8,0.8,0.0], using: Double(time) / 2.5)
            node.geometry?.materials.first?.diffuse.contents = UIColor(cgColor: CGColor(srgbRed: CGFloat(rgbValues[0]), green: CGFloat(rgbValues[1]), blue: CGFloat(rgbValues[2]), alpha: 1.0))
        }
        
        let colorTransition1 = SCNAction.customAction(duration: 8) { (node, time) in
            let rgbValues = vDSP.linearInterpolate([0.8,0.8,0.0], [0.0,0.0,0.0], using: Double(time) / 4.0)
            node.geometry?.materials.first?.diffuse.contents = UIColor(cgColor: CGColor(srgbRed: CGFloat(rgbValues[0]), green: CGFloat(rgbValues[1]), blue: CGFloat(rgbValues[2]), alpha: 1.0))
        }
        var lastTime1 : CGFloat = 0.0
        let mixtureSwelling = SCNAction.customAction(duration: 8) { (node, time) in
            let delta = time - lastTime1
            node.scale.y = Float(1 + time / 4.0)
            node.position.x += Float(delta) / (60.0 * 8.0)
            lastTime1 = time
        }
        
        self.animation = SCNAction.sequence([SCNAction.wait(duration: 1.0),colorTransition0, SCNAction.group([colorTransition1,mixtureSwelling])])
    }
    
    override func start(in container : Container){
        let sceneRoot = GameManager.getInstance().sceneManager.currentExperiment?.sceneRoot
        
        sceneRoot?.addChildNode(smokeParticle)
        smokeParticle.position = container.getAnchor(.up)
        
        container.contentsNode.runAction(self.animation) {
            self.smokeParticle.removeFromParentNode()
        }
    }
}
