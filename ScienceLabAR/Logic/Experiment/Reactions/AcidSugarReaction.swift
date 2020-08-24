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
        super.init()
        self.substanceA = "acidosolforico"
        self.substanceB = "saccarosio"
        self.resultSubstance = SubstanceDictionary.getSubstance("Carbonio")
        var lastTime0 : CGFloat = 0.0
        let colorTransition = SCNAction.customAction(duration: 8) { (node, time) in
            let rgbValues = vDSP.linearInterpolate([1.0,1.0,1.0], [0.0,0.0,0.0], using: Double(time) / 3.0)
            node.geometry?.materials.first?.diffuse.contents = UIColor(cgColor: CGColor(srgbRed: CGFloat(rgbValues[0]), green: CGFloat(rgbValues[1]), blue: CGFloat(rgbValues[2]), alpha: 1.0))
        }
        var lastTime1 : CGFloat = 0.0
        let mixtureSwelling = SCNAction.customAction(duration: 8) { (node, time) in
            let delta = time - lastTime1
            node.scale.y = Float(1 + time / 4.0)
            node.position.x += Float(delta) / (60.0 * 4.0)
            lastTime1 = time
        }
        
        self.animation = SCNAction.group([colorTransition,mixtureSwelling])
    }
    
    override func start(in container : Container){
        var acidFlag = false
        var sugarFlag = false
        
        for s in container.contents.keys{
            if s.name == "acidosolforico"{
                acidFlag = true
            }
            else if s.name == "saccarosio"{
                sugarFlag = true
            }
        }
        
        if acidFlag && sugarFlag{
            print("reaction start")
            container.contentsNode.runAction(self.animation) {
                print("reaction end")
            }
        }
        else{
            print("Reactors not present.")
        }
    }
    
}
