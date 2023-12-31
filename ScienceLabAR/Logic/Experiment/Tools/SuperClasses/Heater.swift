//
//  Heaters.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 16/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit

class Heater : Tool{
    
    var heatedTool : Tool?
    var isActive : Bool = false
    
    override init(_ node : SCNNode, _ displayName: String){
        super.init(node, displayName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func spawn(_ experiment: Experiment){
        super.spawn(experiment)
        experiment.menuManager?.createHeaterMenu()
    }
    
    func toggleActive(){}
    
    static func instantiate (_ node : SCNNode, _ name : String, _ params : [String:Any]?) -> Heater?{
        if name == "bunsen"{
            return Bunsen(node, name)
        }
        return nil
    }
}
