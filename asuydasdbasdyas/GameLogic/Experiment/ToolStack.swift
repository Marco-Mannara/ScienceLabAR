//
//  ToolStack.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 20/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation

class ToolStack{
    
    private var tools : [Tool]
    
    init(){
        tools = []
    }

    func addTool(_ tool: Tool){
        for t in tools{
            t.toolAddedToStack(tool)
        }
        tools.append(tool)
    }
    
    func removeTool(_ tool : Tool){
        if let index = tools.firstIndex(of: tool){
            tools.remove(at: index)
        }
    }
    
    func isEmpty() -> Bool{
        return tools.count == 0
    }
    
}
