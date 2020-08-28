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
            var sumColorR : CGFloat = 0.0
            var sumColorG : CGFloat = 0.0
            var sumColorB : CGFloat = 0.0
            var sumColorA : CGFloat = 0.0
            let contentsVolume = Float(contentsVolumeInMilliliters)
            var proportions : Float = 0.0
            
            for content in contents{
                proportions = Float(content.volume) / contentsVolume
                sumColorR += (content.substance.color.cgColor.components?[0] ?? 0.0) * CGFloat(proportions)
                sumColorG += (content.substance.color.cgColor.components?[1] ?? 0.0) * CGFloat(proportions)
                sumColorB += (content.substance.color.cgColor.components?[2] ?? 0.0) * CGFloat(proportions)
                sumColorA += (content.substance.color.cgColor.components?[3] ?? 1.0) * CGFloat(proportions)
            }
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
