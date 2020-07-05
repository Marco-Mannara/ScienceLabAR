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
        guard let url = Bundle.main.url(forResource: "experiments", withExtension: "plist") else {return nil}
        let data = try! Data(contentsOf: url)
        let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String:Any]
        
        var props : [ExperimentProperties] = []
        
        for experiment in dict{
            let properties = (experiment.value as! [String : Any])["properties"] as! [String:Any]
            props.append(ExperimentProperties(properties["name"] as! String,experiment.key,properties["imageName"] as? String))
        }
        return props
    }
    
    static func loadExperiment(_ name : String) -> Experiment?{
        let experiment = Experiment()
        experiment.load(name)
        return experiment
    }
}
