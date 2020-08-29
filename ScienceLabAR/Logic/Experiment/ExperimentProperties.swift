//
//  ExperimentProperties.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 03/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

struct ExperimentProperties{
    var name : String
    var storedName : String
    var imageName : String?
    
    init(_ name : String,_ storedName : String ,_ imageName: String? = nil){
        self.name = name
        self.storedName = storedName
        self.imageName = imageName
    }
}

