//
//  UpdateManager.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 25/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import GameplayKit
import SceneKit

class UpdateManager
{
    var subscribedEntities : [GKEntity] = []
    
    private var lastUpdate : Double = 0.0
    private var deltaTime : Double = 0.0
    private var isFirstUpdate : Bool = true
    
    func update(_ time: TimeInterval){
        if isFirstUpdate {
            lastUpdate = time
            isFirstUpdate = false
            return
        }
        deltaTime = time - lastUpdate
        lastUpdate = time
        
        //print(deltaTime)
        
        for e in subscribedEntities{
            e.update(deltaTime: deltaTime)
        }
    }
    
    func subscribe(_ entity : GKEntity){
        subscribedEntities.append(entity)
    }
    
    func unsubscribe(){
        
    }
}
