//
//  ReactionDictionary.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 25/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
class ReactionDictionary{
    
    private static var reactions : [ReactorTuple : Reaction] = [:]
    
    init(){
        ReactionDictionary.reactions[ReactorTuple("acidosolforico","saccarosio")] = AcidSugarReaction.instance
    }
    
    static func getReaction(_ substance0 : Substance,_ substance1 : Substance) -> Reaction?{
        let reactorTuple = ReactorTuple(substance0.name,substance1.name)
        
        if let reaction = reactions[reactorTuple]{
            return reaction
        }
        else{
            let reactorTupleInverse = ReactorTuple(substance1.name, substance0.name)
            return reactions[reactorTupleInverse]
        }
    }
}

struct ReactorTuple : Hashable{
    var substance0 : String
    var substance1 : String
    
    init(_ substance0 : String, _ substance1: String){
        self.substance0 = substance0
        self.substance1 = substance1
    }
    
    static func == (lhs: ReactorTuple, rhs: ReactorTuple) -> Bool{
        if lhs.substance0 == rhs.substance0 && lhs.substance1 == rhs.substance1 {
            return true
        }
        if lhs.substance1 == rhs.substance0 && lhs.substance0 == rhs.substance1 {
            return true
        }
        else{
            return false
        }
    }
    
    func check(_ substance0 : Substance, _ substance1 : Substance) -> Bool{
        if self.substance0 == substance0.name && self.substance1 == substance1.name {
            return true
        }
        if self.substance1 == substance0.name && self.substance0 == substance1.name {
            return true
        }
        else{
            return false
        }
    }
}
