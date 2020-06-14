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
    
    private var restPoints : [SCNNode]
    private lazy var hint : HintSystem = HintSystem(self)
    
    init(_ scene: SCNScene){
        self.scene = scene
        self.restPoints = []
        self.tools = []
        
        if let root = scene.rootNode.childNode(withName: "SCENE_ROOT", recursively: false){
            sceneRoot = root
        }
        else{
            fatalError("Couldn't find SCENE_ROOT node")
        }
        
        readDataFromJSON()
        setupScene()
    }
    
    private func readDataFromJSON(){
        if let path = Bundle.main.url(forResource: "firstExperiment", withExtension: "json"){
            do {
                //let toolScene = SCNScene(named: "art.scnassets/tools/tools.scn")!
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    if let neededTools = jsonResult["tools"] as? Dictionary<String,AnyObject>{
                        setupTools(neededTools)
                    }
                }
            } catch {
                print("Failed to read json file")
            }
        }
    }
    
    private func setupTools(_ toolsDict : Dictionary<String,AnyObject>){
        if let neededContainers = toolsDict["containers"] as? [String]{
            for container in neededContainers {
                if let toolNode = ScnModelLoader.loadModel("tools/tools",container){
                    tools.append(LiquidContainer.instantiate(toolNode, container, [100.0])!)
                }
                else{
                    print("Couldn't find model for " + container )
                }
            }
        }
    }
    
    
    func setupScene(){
        var lastUsedRestPoint = 0
        
        for node in sceneRoot.childNodes{
            let nodeName = node.name
            if nodeName!.hasPrefix("spawnPoint")  {
                //print("Spawnpoint found and added.")
                restPoints.append(node)
            }
        }
        
        for tool in tools {
            if lastUsedRestPoint < restPoints.count{
                tool.spawn(sceneRoot)
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
    
    func selectTool(_ tool : Tool){
        hint.highLightTool(tool)
    }
    
    func onToolHit(_ tool : Tool){
        selectTool(tool)
    }
}

/*
  else if nodeName?.hasSuffix("tool") ?? false{
      let startIndex = nodeName!.startIndex
      let endIndex = nodeName!.index(nodeName!.endIndex, offsetBy: -6)
      let splicedName = String(nodeName![startIndex ... endIndex])
      
      print(splicedName)
*/
