//
//  ToolStack.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 20/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class ToolStack{
    
    private var tools : [String : Tool]
    
    init(){
        tools = [:]
    }
    
    func addTool(_ tool: Tool){
        if let _ = tool as? Stackable{
            for t in tools{
                let stackable = t as! Stackable
                stackable.toolAddedToStack(tool)
            }
            tools[tool.displayName] = tool
        }
    }
    
    func removeTool(_ tool : Tool){
        tools.removeValue(forKey: tool.displayName)
    }
    
    func isEmpty() -> Bool{
        return tools.count == 0
    }
    
}
