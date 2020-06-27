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
            vol += c.volumeInMilliliters
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
    
    func fill(with substance: Substance){}
    
    func draw() -> Substance?{ return nil }
    
    static func instantiate(_ node: SCNNode,_ containerName: String, _ params: [String:Any]?) -> Container? {
        
        if containerName == "becker"{
            if let volumeCap = params?["volumeCapacity"] as? Double{
                let becker = Becker(node, containerName, Float(volumeCap))
                //let substance = Substance("H20", 7.0, 1.0)
                //substance.volumeInMilliliters = 250
                if let substance = params?["substance"] as? Substance{
                    becker.fill(with: substance)
                }
                return becker
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
        else if containerName == "spatula"{
            if let volumeCap = params?["volumeCapacity"] as? Double{
                return Spatula(node, containerName, Float(volumeCap))
            }
            else{
                print("No parameter was passed to Spatula instantiation")
                return nil
            }
        }
        else if containerName == "piattino" {
            if let volumeCap = params?["volumeCapacity"] as? Double{
                let piattino = Piattino(node, containerName, Float(volumeCap))
                if let substanceParams = params?["substance"] as? [String:Any]{
                    let substance = Substance(substanceParams)
                    piattino.fill(with: substance)
                }
                return piattino
            }
            else{
                print("No parameter was passed to Becker instantiation")
                return nil
            }
        }
        else{
            return nil
        }
    }
}
