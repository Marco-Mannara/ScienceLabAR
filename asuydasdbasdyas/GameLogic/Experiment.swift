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
    var restPoints : [SCNNode]
    var tools : [Tool]
   
    init(_ scene: SCNScene){
        self.scene = scene
        self.restPoints = []
        self.tools = []
        
        readDataFromJSON()
        setupScene()
    }
    
    private func readDataFromJSON(){
        if let path = Bundle.main.url(forResource: "firstExperiment", withExtension: "json"){
            do {
                let toolScene = SCNScene(named: "art.scnassets/tools/tools.scn")!
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    if let neededTools = jsonResult["tools"] as? Dictionary<String,AnyObject>{
                        if let neededContainers = neededTools["containers"] as? [String]{
                            for container in neededContainers {
                                if let toolNode = toolScene.rootNode.childNode(withName: container, recursively: true){
                
                                    tools.append(Tool(toolNode, container))
                                }
                            }
                        }
                    }
                }
        } catch {
            print("Failed to read json file")
        }
        }
    }
    
    private func setupScene(){
        var lastUsedRestPoint = 0
        
        for node in scene.rootNode.childNodes{
            let nodeName = node.name
            if nodeName == "spawnPoint" {
                //print("Spawnpoint found and added.")
                restPoints.append(node)
            }
        }
        
        for tool in tools {
            if lastUsedRestPoint < restPoints.count{
                scene.rootNode.addChildNode(tool.node)
                tool.node.setHighlighted()
                tool.restPoint = restPoints[lastUsedRestPoint]
                tool.resetPosition()
                
                lastUsedRestPoint += 1
            }
            else{
                fatalError("Not enough rest points")
            }
        }
    }
}

/*
  else if nodeName?.hasSuffix("tool") ?? false{
      let startIndex = nodeName!.startIndex
      let endIndex = nodeName!.index(nodeName!.endIndex, offsetBy: -6)
      let splicedName = String(nodeName![startIndex ... endIndex])
      
      print(splicedName)
*/
