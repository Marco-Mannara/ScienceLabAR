//
//  GameManager.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 25/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import ARKit
import SceneKit
import SpriteKit

class GameManager {
    
    private static var instance : GameManager?
    
    var updateManager : UpdateManager!
    var sceneManager : SceneManager!
    var inputManager : InputManager!
    
    private init(){
        updateManager = UpdateManager()
        inputManager = InputManager()
        sceneManager = SceneManager()
    }
    
    static func getInstance() -> GameManager{
        if GameManager.instance == nil{
            GameManager.instance = GameManager()
        }
        return GameManager.instance!
    }
}
