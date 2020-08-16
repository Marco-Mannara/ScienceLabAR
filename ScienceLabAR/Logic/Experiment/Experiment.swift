//
//  Experiment.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 11/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SceneKit
import SpriteKit

class Experiment {
    
    var tools : [Tool]
    
    var scene : SCNScene?
    var sceneRoot : SCNNode?
    var restPoints : [SCNNode]
    
    var workPosition : WorkPosition?
    var selection : SelectionSystem?
    var hint : HintSystem?
    var menuManager : ToolMenuManager?
    var goals : GoalSystem?
    
    init(){
        self.restPoints = []
        self.tools = []

    }
    
    func load(_ experimentName : String){
        SubstanceDictionary.open()
        
        guard let url = Bundle.main.url(forResource: "experiments", withExtension: "plist") else {return}
        let data = try! Data(contentsOf: url)
        let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String:Any]
        
        if let experiment = dict[experimentName] as? [String:Any]{
            loadTools(experiment)
        }
        SubstanceDictionary.close()
    }
    
    func spawn (in scene: SCNScene){
        self.scene = scene
        
        var lastUsedRestPoint = 0
        if let root = scene.rootNode.childNode(withName: "SCENE_ROOT", recursively: false){
            sceneRoot = root
        }
        else{
            fatalError("Couldn't find SCENE_ROOT node")
        }
        let spawnPoints = sceneRoot!.childNodes(passingTest: {(node,flag) -> Bool in
               return node.name?.hasPrefix("spawnPoint") ?? false
        })
        
        restPoints.append(contentsOf: spawnPoints)
        
        self.selection = SelectionSystem(self)
        self.hint = HintSystem(self)
        self.menuManager = ToolMenuManager(self)
        
        let workPositionNode = sceneRoot!.childNode(withName: "workPosition", recursively: false)!
        workPosition = WorkPosition(self,workPositionNode)
        
        for tool in tools {
            if lastUsedRestPoint < restPoints.count{
                tool.spawn(self)
                tool.restPoint = restPoints[lastUsedRestPoint]
                tool.reset()
                
                lastUsedRestPoint += 1
            }
            else{
                fatalError("Not enough rest points")
            }
        }
        menuManager?.spawn()
    }
    
    private func loadTools(_ toolsDict : [String:Any]){
        
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
    }
    
    func onToolTap(_ tool : Tool){
        if tools.contains(tool) {
            let toolState = tool.state?.currentState as! ToolState
            toolState.onTap()
        }else{
            fatalError("Tool not found")
        }
    }
    
    func getCompatibleTools(for tool: Tool) -> [Tool]{
        var compatibleTools : [Tool] = []
        for t in tools{
            if(tool.isCompatible(t)){
                compatibleTools.append(t)
            }
        }
        return compatibleTools
    }
}
