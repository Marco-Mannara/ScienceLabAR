
//
//  ToolMenuManager.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 29/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class ToolMenuManager{
    
    var experiment : Experiment
    
    var idleMenu : ToolMenu!
    var positionedMenu : ToolMenu!
    var heaterMenu : ToolMenu?
    
    var symbols : [String : SCNNode]
    
    init(_ experiment : Experiment){
        self.experiment = experiment
        
        symbols = [:]
        
        symbols["pickup"] = ScnModelLoader.loadModel("interaction_symbols/symbols","hand_symbol")!
        symbols["cancel"] = ScnModelLoader.loadModel("interaction_symbols/symbols","cancel_symbol")!
        symbols["return"] = ScnModelLoader.loadModel("interaction_symbols/symbols","return_symbol")!
        symbols["switch"] = ScnModelLoader.loadModel("interaction_symbols/symbols","onoff_symbol")!
        
        
        setup()
    }
    
    func setup(){
        createIdleMenu()
        createPositionedMenu()
    }
    
    func createHeaterMenu(){
        heaterMenu = ToolMenu(experiment,StatePositioned.self)
        
        heaterMenu?.addEntry(symbols["switch"]!.clone(), { (tool : Tool) in
            if let heater = tool as? Heater{
                heater.toggleActive()
            }
        })
        
        heaterMenu?.addEntry(symbols["return"]!.clone(), { (tool : Tool) in
            tool.state?.enter(StateIdle.self)
            self.experiment.workPosition?.remove(tool)
        })
        
        
        heaterMenu?.addEntry(symbols["cancel"]!.clone(), { (tool : Tool) in
            tool.state?.enter(StatePositioned.self)
        })
    }
    
    private func createIdleMenu(){
        idleMenu = ToolMenu(experiment,StateIdle.self)
        
        idleMenu.addEntry(symbols["pickup"]!.clone(), {(tool : Tool) -> Void in
            if tool.state?.enter(StatePickedUp.self) ?? false{
                self.idleMenu.hide()
            }
        })
        idleMenu.addEntry(symbols["cancel"]!.clone(), {(tool : Tool) -> Void in
                tool.state?.enter(StateIdle.self)
        })
    }
    
    private func createPositionedMenu(){
        positionedMenu = ToolMenu(experiment,StatePositioned.self)
        positionedMenu.addEntry(symbols["return"]!.clone(), {(tool) -> Void in
            tool.state?.enter(StateIdle.self)
            self.experiment.workPosition?.remove(tool)
        })
        positionedMenu.addEntry(symbols["cancel"]!.clone(), {(tool) -> Void in
            tool.state?.enter(StatePositioned.self)
        })
    }
    
    func spawn(){
        idleMenu.spawn()
        positionedMenu.spawn()
        
        heaterMenu?.spawn()
    }
    
    func display(_ tool: Tool){
        //if type(of: tool.state?.currentState) == StateMenuActive.self{
        if tool.state?.currentState is StateMenuActive{
            if tool is Heater{
                heaterMenu!.display(tool)
            }
            else{
                positionedMenu.display(tool)
            }
        }
        else if type(of: tool.state?.currentState) == StateIdle.self{
            idleMenu.display(tool)
        }
    }
    
    func hide(){
        idleMenu.hide()
        positionedMenu.hide()
        
        heaterMenu?.hide()
    }
}
