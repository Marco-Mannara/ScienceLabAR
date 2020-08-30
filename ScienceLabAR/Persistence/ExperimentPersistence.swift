//
//  ExperimentLoader.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 03/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class ExperimentPersistence{
    
    private static var experimentProps : [ExperimentProperties] = []
    
    static func fetchAllExperimentProperties() -> [ExperimentProperties]?{
        if experimentProps.count > 0{
            return experimentProps
        }
        else{
            guard let url = Bundle.main.url(forResource: "experiment_properties", withExtension: "plist") else {return nil}
            let data = try! Data(contentsOf: url)
            let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [[String:Any]]
            
            var props : [ExperimentProperties] = []
            
            for prop in dict{
                props.append(ExperimentProperties(prop["name"] as! String,prop["storedName"] as! String ,prop["imageName"] as? String))
            }
            experimentProps.append(contentsOf: props)
            return props
        }
    }
    
    static func updateExperimentCompletition(for experiment: String){
        guard let url = Bundle.main.url(forResource: "experiment_properties", withExtension: "plist") else {return}
        let data = try! Data(contentsOf: url)
        let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainersAndLeaves, format: nil) as! [[String:Any]]
        for var prop in dict{
            prop["completed"] = true
        }
    }
    
    static func loadExplanation(with name: String) -> String?{
        guard let url = Bundle.main.url(forResource: "experiment_explanation", withExtension: "plist") else {return nil}
        let data = try! Data(contentsOf: url)
        let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String:String]
        
        if let fileName = dict[name]{
            guard let url = Bundle.main.url(forResource: fileName, withExtension: "txt") else {return nil}
            let explanation = try! String(contentsOf: url,encoding: .utf8)
            return explanation
        }
        return nil
    }
    
    static func loadExperiment(_ experimentName : String) -> Experiment?{
        let experiment = Experiment(experimentName)
        
        guard let url = Bundle.main.url(forResource: "experiments", withExtension: "plist") else {return nil}
        let data = try! Data(contentsOf: url)
        let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String:Any]
        
        loadSubstances(experimentName)
        
        let _ = ReactionDictionary.init()
        
        if let experimentData = dict[experimentName] as? [String:Any]{
            experiment.tools.append(contentsOf: loadTools(experimentData))
        }
        experiment.goals = setupGoalSystem(experimentName)
        
        return experiment
    }
    
    private static func loadSubstances(_ experimentName : String){
        SubstanceDictionary.open()
        guard let url = Bundle.main.url(forResource: "experiment_substances", withExtension: "plist") else {
            fatalError("Couldn't load substances for \(experimentName)")
        }
        let data = try! Data(contentsOf: url)
        let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String:Any]
        
        if let experimentSubstances = dict[experimentName] as? [String]{
            for substance in experimentSubstances{
                SubstanceDictionary.loadSubstance(substance)
            }
        }
        SubstanceDictionary.close()
    }
    
    private static func setupGoalSystem(_ experimentName : String) -> GoalSystem{
        let goalSystem = GoalSystem()
        let name = experimentName.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        switch name {
        case "saggioallafiamma":
            let goal0 = InteractionGoal("Saggio Cloruro di Litio",{ (tool0 : Tool,tool1 : Tool) -> Bool in
                if let _ = tool0 as? Bunsen,let becco = tool1 as? Becco{
                    if becco.contents.first?.substance.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "clorurodilitio"{
                        return true
                    }
                }
                return false
            })
            let goal1 = InteractionGoal("Saggio Nitrato Rameico",{ (tool0 : Tool,tool1 : Tool) -> Bool in
                if let _ = tool0 as? Bunsen,let becco = tool1 as? Becco{
                    if becco.contents.first?.substance.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "nitratorameico"{
                        return true
                    }
                }
                return false
            })
            let goal2 = InteractionGoal("Saggio Nitrato di Potassio",{ (tool0 : Tool,tool1 : Tool) -> Bool in
                if let _ = tool0 as? Bunsen,let becco = tool1 as? Becco{
                    if becco.contents.first?.substance.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "nitratodipotassio"{
                        return true
                    }
                }
                return false
            })
            let goal3 = InteractionGoal("Saggio Cloruro Rameoso",{ (tool0 : Tool,tool1 : Tool) -> Bool in
                if let _ = tool0 as? Bunsen,let becco = tool1 as? Becco{
                    if becco.contents.first?.substance.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "clorurorameoso"{
                        return true
                    }
                }
                return false
            })
            let goal4 = InteractionGoal("Saggio Cloruro di Sodio",{ (tool0 : Tool,tool1 : Tool) -> Bool in
                if let _ = tool0 as? Bunsen,let becco = tool1 as? Becco{
                    if becco.contents.first?.substance.name.lowercased().trimmingCharacters(in: .whitespacesAndNewlines) == "clorurodisodio"{
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
        case "carbonizzazionedelsaccarosio":
            let goal0 = ReactionGoal("Carbonizzazione Saccarosio Acido",{ (reaction : Reaction) -> Bool in
                
                if let _ = reaction as? AcidSugarReaction {
                    return true
                }
                return false
                /*
                if let _ = tool0 as? Becker,let beckerReceiver = tool1 as? Becker{
                    var acidoFlag = false
                    var zuccheroFlag = false
                    for c in beckerReceiver.contents{
                        if c.substance.name == "acidosolforico"{
                            acidoFlag = true
                        }
                        else if c.substance.name == "saccarosio"{
                            zuccheroFlag = true
                        }
                    }
                    if acidoFlag && zuccheroFlag {
                        return true
                    }
                    else{
                        return false
                    }
                }
                return false*/
            })
            goalSystem.goals.append(goal0)
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
