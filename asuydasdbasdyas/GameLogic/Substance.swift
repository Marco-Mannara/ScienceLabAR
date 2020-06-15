//
//  Chemical.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 11/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class Substance : NSObject, NSCoding{
    
    var molecule : String = ""
    var PH : Double = 7.0 {
        didSet{
            if PH < 1.0 || PH > 15{
                PH = oldValue
            }
        }
    }
    var density : Double = 1.0
    var volume : Double = 0.0
    var qualityFlag : Bool = false
    
    required init?(coder: NSCoder) {
        guard let molecule = coder.decodeObject(forKey: "molecule") as? String else {
            return nil
        }
        self.molecule = molecule
        self.PH = coder.decodeDouble(forKey: "PH")
        self.density = coder.decodeDouble(forKey: "density")
        qualityFlag = true
    }
    
    func encode(with coder: NSCoder) {
         
    }
}
