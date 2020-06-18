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
    
    var scene : SCNScene
    var tools : [Tool]
    var sceneRoot : SCNNode
    
    var workPosition : WorkPosition?
    
    var selection : SelectionSystem?
    var hint : HintSystem?
    var toolMenu : ToolMenu?
    
    var restPoints : [SCNNode]
    
    
    init(_ scene: SCNScene,_ name: String){
        self.scene = scene
        self.restPoints = []
        self.tools = []
        
        if let root = scene.rootNode.childNode(withName: "SCENE_ROOT", recursively: false){
            sceneRoot = root
        }
        else{
            fatalError("Couldn't find SCENE_ROOT node")
        }
        
        self.selection = SelectionSystem(self)
        self.hint = HintSystem(self)
        self.toolMenu = ToolMenu(self)
        
        deserialize(name)
        setup()
    }
    
    private func deserialize(_ experimentName : String){

        guard let url = Bundle.main.url(forResource: "experiments", withExtension: "plist") else {return}
        let data = try! Data(contentsOf: url)
        let dict = try! PropertyListSerialization.propertyList(from: data, options: .mutableContainers, format: nil) as! [String:Any]
        
        if let experiment = dict[experimentName] as? [String:Any]{
            setupTools(experiment)
        }
        
        
        /*
         do {
         let data = try Data(contentsOf: path, options: .mappedIfSafe)
         let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
         if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
         if let neededTools = jsonResult["tools"] as? Dictionary<String,AnyObject>{
         setupTools(neededTools)
         }
         }
         } catch {
         print("Failed to read json file")
         }*/
    }
    
    private func setupTools(_ toolsDict : [String:Any]){
        
        
        if let neededContainers = toolsDict["containers"] as? [String:Any]{
            for container in neededContainers {
                if let toolNode = ScnModelLoader.loadModel("tools/tools",container.key){
                    tools.append(LiquidContainer.instantiate(toolNode, container.key, container.value as? [String:Any])!)
                }
                else{
                    print("Couldn't find model for " + container.key )
                }
            }
        }
        
        if let heaters = toolsDict["heaters"] as? [String]{
            for tool in heaters {
                if let toolNode = ScnModelLoader.loadModel("tools/" + tool,tool){
                    tools.append(Heater.instantiate(toolNode, tool, nil)!)
                }
            }
        }
        
        if let otherTools = toolsDict["other"] as? [String]{
            for tool in otherTools{
                if let toolNode = ScnModelLoader.loadModel("tools/" + tool,tool){
                    tools.append(Tool.instantiate(toolNode, tool)!)
                }
            }
        }
    }
    
    
    func setup(){
        var lastUsedRestPoint = 0
        
        let spawnPoints = sceneRoot.childNodes(passingTest: {(node,flag) -> Bool in
            return node.name?.hasPrefix("spawnPoint") ?? false
        })
        
        restPoints.append(contentsOf: spawnPoints)
        
        let workPositionNode = sceneRoot.childNode(withName: "workPosition", recursively: false)!
        workPosition = WorkPosition(self,workPositionNode)
        
        //camera = sceneRoot.childNode(withName: "mainCamera", recursively: false)!
        
        for tool in tools {
            if lastUsedRestPoint < restPoints.count{
                tool.spawn(self)
                tool.restPoint = restPoints[lastUsedRestPoint]
                tool.resetPosition()
                
                lastUsedRestPoint += 1
            }
            else{
                fatalError("Not enough rest points")
            }
        }
    }
    
    func resetExperiment(){
        
    }
    
    func deleteScene(){
        
    }
    
    func onToolTap(_ tool : Tool){
        if tools.contains(tool) {
            let toolState = tool.state?.currentState as! ToolState
            toolState.onTap()
            //hint.highLightTool(tool)
            //toolMenu.display(tool)
        }else{
            fatalError("Tool not found")
        }
    }
    /*
    func deselectTool(_ tool : Tool){
        if tools.contains(tool){
            hint.disableHighlight()
            toolMenu.hide()
        }else{
            fatalError("Tool not found")
        }
    }*/
}

/*
  else if nodeName?.hasSuffix("tool") ?? false{
      let startIndex = nodeName!.startIndex
      let endIndex = nodeName!.index(nodeName!.endIndex, offsetBy: -6)
      let splicedName = String(nodeName![startIndex ... endIndex])
      
      print(splicedName)
*/
