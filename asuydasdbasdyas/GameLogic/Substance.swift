//
//  Chemical.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 11/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class Substance : NSObject, NSCoding{
    
    var name : String = ""
    var molecule : String = ""
    var PH : Double = 7.0 {
        didSet{
            if PH < 1.0 || PH > 15{
                PH = oldValue
            }
        }
    }
    var density : Double = 1.0
    var color : UIColor = UIColor.white
    var flameColor : UIColor = UIColor.orange
    var state : PhysicState = .solid
    
    var qualityFlag : Bool = false
    
    init(_ name : String,_ molecule : String, _ PH : Double, _ density: Double, _ physicState : PhysicState = .solid){
        self.name = name
        self.molecule = molecule
        self.PH = PH
        self.density = density
        self.state = physicState
        
        qualityFlag = true
    }
    
    required convenience init?(coder: NSCoder) {
        guard let molecule = coder.decodeObject(forKey: "molecule") as? String else {
            return nil
        }
        let PH = coder.decodeDouble(forKey: "PH")
        let density = coder.decodeDouble(forKey: "density")
        
        self.init("",molecule,PH,density)
    }
    
    convenience init (_ params : [String : Any]){
        let name = params["name"] as? String ?? ""
        let molecule = params["molecule"] as? String ?? ""
        let PH = params["PH"] as? Double ?? 7
        let density = params["density"] as? Double ?? 1
        
        let color = params["color"] as? [Double] ?? [0.0,0.0,0.0]
        let flameColor = params["flameColor"] as? [Double] ?? [0.0,0.0,0.0]
        
        self.init(name,molecule,PH,density)
        
        self.color = UIColor(_colorLiteralRed: Float(color[0]),green: Float(color[1]),blue: Float(color[2]), alpha: 1)
        self.flameColor = UIColor(_colorLiteralRed: Float(flameColor[0]),green: Float(flameColor[1]),blue: Float(flameColor[2]), alpha: 1)
    }
    
    
    func encode(with coder: NSCoder) {
        
    }
}

enum PhysicState : Int{
    case solid = 0
    case liquid = 1
    case gas = 2
}
