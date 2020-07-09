//
//  Container.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 11/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit


class Container : Tool{
    var contents : [Substance]
    var contentsVolume : Float{
        var vol = 0.0
        for c in contents{
            vol += c.volume
        }
        return Float(vol)
    }
    var contentsWeight : Float{
        var weight = 0.0
        for c in contents{
            weight += c.mass
        }
        return Float(weight)
    }
    var volumeCapacity : Float {
        didSet{
            if volumeCapacity < 0.0{
                volumeCapacity = oldValue
            }
        }
    }
    
    init(_ node : SCNNode, _ displayName : String , _ volumeCapacity : Float){
        self.volumeCapacity = volumeCapacity
        self.contents = []
        
        super.init(node, displayName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    static func instantiate(_ node: SCNNode,_ containerName: String, _ params: [String:Any]?) -> Container? {
        if containerName == "becker"{
            if let volumeCap = params?["volumeCapacity"] as? Double{
                return Becker(node, containerName, Float(volumeCap))
            }
            else{
                print("No parameter was passed to Becker instantiation")
                return nil
            }
        }
        else if containerName == "pipetta"{
            if let volumeCap = params?["volumeCapacity"] as? Double{
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
