//
//  Container.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 11/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit
import Accelerate

class Container : Tool{
    var contents : [(substance : Substance, volume : Float)]
    var contentsNode : SCNNode
    
    var contentsVolumeInMilliliters : Float{
        var vol : Float = 0.0
        for c in contents{
            vol += c.volume
        }
        return vol
    }
    var contentsWeight : Float{
        var weight = 0.0
        for c in contents{
            weight += Double(c.volume) * c.substance.density
        }
        return Float(weight)
    }
    var volumeCapacity : Float = 0.0 {
        didSet{
            if volumeCapacity < 0.0{
                volumeCapacity = oldValue
            }
        }
    }
    
    init(_ node : SCNNode, _ displayName : String , _ volumeCapacity : Float){
        self.volumeCapacity = volumeCapacity
        self.contents = []
        self.contentsNode = node.childNode(withName: "contents", recursively: true)!
        self.contentsNode.isHidden = true
        
        super.init(node, displayName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(with substance: Substance, volume : Float){
        
        let index = contents.firstIndex { (tuple : (substance: Substance, volume: Float)) -> Bool in
            return substance == tuple.substance
        }
        if let index = index{
            contents[index].volume += volume
        }
        else{
            contents.append((substance,volume))
        }
        
        contentsNode.isHidden = false
        
        if contents.count > 1{
            let contentsVolume = Float(contentsVolumeInMilliliters)
            let proportions = volume / contentsVolume
            let diffuse = contentsNode.geometry!.materials.first!.diffuse
            let color = (diffuse.contents! as! UIColor).cgColor.components!
            let substanceColor = substance.color.cgColor.components!
            
            let interpColor : [Float] = vDSP.linearInterpolate( [Float(color[0]),Float(color[1]),Float(color[2]),Float(color[3])],[Float(substanceColor[0]),Float(substanceColor[1]),Float(substanceColor[2]),Float(substanceColor[3])],
                using: proportions)
            
            diffuse.contents = UIColor(_colorLiteralRed: interpColor[0],green: interpColor[1],blue: interpColor[2],alpha: interpColor[3])
        }
        else if contents.count == 1{
            contentsNode.geometry?.materials.first?.diffuse.contents = substance.color
        }
    }
    
    func draw(_ volumeInMilliliters: Float) -> Substance?{
        let contentsVolume = contentsVolumeInMilliliters
        if contentsVolume > 0 && volumeInMilliliters <= contentsVolume{
            contents[0].volume -= volumeInMilliliters
            if volumeInMilliliters >= contentsVolumeInMilliliters - 0.001 && volumeInMilliliters <= contentsVolumeInMilliliters + 0.001{
                contentsNode.isHidden = true
                contents.removeAll()
            }
            return contents.first?.substance
        }
        return nil
    }
    
    func clearContents(){
        contents.removeAll()
        contentsNode.isHidden = true
    }
    
    func setContents(_ newContents : [(substance : Substance, volume : Float)]){
        contents.removeAll()
        contents.append(contentsOf: newContents)
    }
    
    override func getInfo() -> [String] {
        var info = super.getInfo()
        for content in contents{
            info.append(contentsOf: [content.substance.capName, content.substance.molecule,String(content.volume) + "ml"])
        }
        return info
    }
    
    static func instantiate(_ node: SCNNode,_ containerName: String, _ params: [String:Any]?) -> Container? {
        
        if containerName == "becker"{
            if let volumeCap = params?["volumeCapacity"] as? Double{
                let becker = Becker(node, containerName, Float(volumeCap))
                if let substanceProp = params?["substance"] as? [String:Any],let name = substanceProp["name"] as? String, let quantity = substanceProp["quantity"] as? Float
                {
                    let substance = SubstanceDictionary.getSubstance(name)!
                    becker.fill(with: substance, volume: quantity)
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
                if let substanceProp = params?["substance"] as? [String:Any],let name = substanceProp["name"] as? String, let quantity = substanceProp["quantity"] as? Float
                {
                    if let substance = SubstanceDictionary.getSubstance(name){
                        piattino.fill(with: substance, volume: quantity)
                    }
                }
                return piattino
            }
            else{
                print("No parameter was passed to Becker instantiation")
                return nil
            }
        }
        else if containerName == "becco"{
            if let volumeCap = params?["volumeCapacity"] as? Double{
                let becco = Becco(node, containerName, Float(volumeCap))
                return becco
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
