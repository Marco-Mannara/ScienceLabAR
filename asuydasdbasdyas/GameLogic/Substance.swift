//
//  Chemical.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 11/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class Substance {
    var moleculeDesc : String = ""
    var PH : Float = 7.0 {
        didSet{
            if PH < 1.0 || PH > 15{
                PH = oldValue
            }
        }
    }
}
