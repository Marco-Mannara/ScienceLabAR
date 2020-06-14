//
//  Container.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 11/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit


class LiquidContainer : Tool{
    var contentsVolume : Float
    var contentsWeight : Float
    var volumeCapacity : Float {
           didSet{
               if volumeCapacity < 0.0{
                   volumeCapacity = oldValue
               }
           }
       }
    
    init(_ node : SCNNode, _ displayName : String , _ volumeCapacity : Float){
        self.volumeCapacity = volumeCapacity
        self.contentsVolume = 0.0
        self.contentsWeight = 0.0
        super.init(node, displayName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func instantiate(_ node: SCNNode,_ containerName: String, _ params: [Any]?) -> LiquidContainer? {
        if containerName == "becker"{
            if let volumeCap = params?[0] as? Double{
                 return Becker(node, containerName, Float(volumeCap))
            }
            else{
                print("No parameter was passed to Becker instantiation")
                return nil
            }
        }
        else if containerName == "pipetta"{
            if let volumeCap = params?[0] as? Double{
                 return Pipetta(node, containerName, Float(volumeCap))
            }
            else{
                print("No parameter was passed to Pipetta instantiation")
                return nil
            }
        }
        else{
            return nil
        }
    }
}
