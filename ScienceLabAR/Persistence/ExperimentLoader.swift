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
    /*
    static func loadExperiment(_ name : String) -> Experiment?{
        let experiment = Experiment()
        experiment.load(name)
        return experiment
    }*/
    
    static func load(_ experimentName : String) -> Experiment?{
        let experiment = Experiment()
        SubstanceDictionary.open()
        
        guard let url = Bundle.main.url(forResource: "experiments", withExtension: "plist") else {return nil}
        let data = try! Data(contentsOf: url)
        let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String:Any]
        
        if let experimentData = dict[experimentName] as? [String:Any]{
            experiment.tools.append(contentsOf: loadTools(experimentData))
        }
        SubstanceDictionary.close()
        
        experiment.goals = setupGoalSystem(experimentName)
        
        return experiment
    }
    
    private static func setupGoalSystem(_ experimentName : String) -> GoalSystem{
        let goalSystem = GoalSystem()
        let name = experimentName.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        switch name {
        case "saggioallafiamma":
            let goal0 = Goal("Saggio Cloruro di Litio",{ (tool0 : Tool,tool1 : Tool) -> Bool in
                if let _ = tool0 as? Bunsen,let becco = tool1 as? Becco{
                    if becco.contents.first!.key.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "clorurodilitio"{
                        return true
                    }
                }
                return false
            })
            let goal1 = Goal("Saggio Nitrato Rameico",{ (tool0 : Tool,tool1 : Tool) -> Bool in
                if let _ = tool0 as? Bunsen,let becco = tool1 as? Becco{
                    if becco.contents.first!.key.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "nitratorameico"{
                        return true
                    }
                }
                return false
            })
            let goal2 = Goal("Saggio Nitrato di Potassio",{ (tool0 : Tool,tool1 : Tool) -> Bool in
                if let _ = tool0 as? Bunsen,let becco = tool1 as? Becco{
                    if becco.contents.first!.key.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "nitratodipotassio"{
                        return true
                    }
                }
                return false
            })
            let goal3 = Goal("Saggio Cloruro Rameoso",{ (tool0 : Tool,tool1 : Tool) -> Bool in
                if let _ = tool0 as? Bunsen,let becco = tool1 as? Becco{
                    if becco.contents.first!.key.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "clorurorameoso"{
                        return true
                    }
                }
                return false
            })
            let goal4 = Goal("Saggio Cloruro di Sodio",{ (tool0 : Tool,tool1 : Tool) -> Bool in
                if let _ = tool0 as? Bunsen,let becco = tool1 as? Becco{
                    if becco.contents.first!.key.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "clorurodisodio"{
                        return true
                    }
                }
                return false
            })
            goalSystem.goals.append(goal0)
            goalSystem.goals.append(goal1)
            goalSystem.goals.append(goal2)
            goalSystem.goals.append(goal3)
            goalSystem.goals.append(goal4)
        case "carbonizzazionedelsaccrosio":
            break
        default:
            fatalError("Could not load goal system for \(name)")
        }
        return goalSystem
    }
    
    private static func loadTools(_ toolsDict : [String:Any]) -> [Tool]{
        var tools : [Tool] = []
        if let neededContainers = toolsDict["containers"] as? [[String:Any]]{
            for container in neededContainers {
                let displayName = container["displayName"] as! String
                if let toolNode = NodeLoader.loadModel("tools/tools",displayName){
                    tools.append(Container.instantiate(toolNode, displayName, container)!)
                }
                else if let toolNode = NodeLoader.loadModel("tools/" + displayName, displayName){
                    tools.append(Container.instantiate(toolNode, displayName, container)!)
                }
                else{
                    print("Couldn't find model for " + displayName )
                }
            }
        }
        
        if let heaters = toolsDict["heaters"] as? [String]{
            for tool in heaters {
                if let toolNode = NodeLoader.loadModel("tools/" + tool,tool){
                    tools.append(Heater.instantiate(toolNode, tool, nil)!)
                }
            }
        }
        
        if let otherTools = toolsDict["other"] as? [String]{
            for tool in otherTools{
                if let toolNode = NodeLoader.loadModel("tools/" + tool,tool){
                    tools.append(Tool.instantiate(toolNode, tool)!)
                }
            }
        }
        return tools
    }
}
