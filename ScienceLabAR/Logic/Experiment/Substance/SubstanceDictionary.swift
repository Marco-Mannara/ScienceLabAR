//
//  SubstanceDictionary.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 28/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class SubstanceDictionary{
    
    static private var substances : [String : Substance] = [:]
    static private var fileHandle : [String : Any]?
    
    
    static func open(){
        guard let url = Bundle.main.url(forResource: "substance", withExtension: "plist") else {return}
        let data = try! Data(contentsOf: url)
        let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String:Any]
        fileHandle = dict
    }
    
    static func getSubstance(_ name : String) -> Substance?{
        if let substance = substances[name]{
            return substance
        }
        else if let properties = fileHandle?[name] as? [String:Any]{
            let substance = Substance(properties)
            substances[name] = substance
            return substance
        }
        else{
            print("Couldn't find substance \(name)")
        }
        return nil
    }
    
    static func close(){
        fileHandle = nil
    }
}
