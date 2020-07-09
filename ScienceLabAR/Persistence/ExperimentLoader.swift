//
//  ExperimentLoader.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 03/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class ExperimentLoader{
    
    static func fetchAllExperimentProperties() -> [ExperimentProperties]?{
        guard let url = Bundle.main.url(forResource: "experiment_properties", withExtension: "plist") else {return nil}
        let data = try! Data(contentsOf: url)
        let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [[String:Any]]
        
        var props : [ExperimentProperties] = []
        
        for prop in dict{
            props.append(ExperimentProperties(prop["name"] as! String,prop["storedName"] as! String, prop["imageName"] as? String))
        }
        return props
    }
    
    static func loadExperiment(_ name : String) -> Experiment?{
        let experiment = Experiment()
        experiment.load(name)
        return experiment
    }
}
