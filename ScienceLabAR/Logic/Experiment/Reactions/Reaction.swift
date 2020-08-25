//
//  Reaction.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 23/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class Reaction{
    var animation : SCNAction!
    var substanceA : String!
    var substanceB : String!
    var resultSubstance : Substance!
    
    init(){}
    
    init(_ substanceA : String, _ substanceB : String, _ animation : SCNAction, _ resultSubstance : Substance){
        self.animation = animation
        self.substanceA = substanceA
        self.substanceB = substanceB
        self.resultSubstance = resultSubstance
    }
    
    func start(in container : Container){}
}
