//
//  SCNVector3Extension.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 20/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SceneKit

extension SCNVector3{
    
    
    func magnitude()->Float{
        return sqrt(x*x + y*y + z*z)
    }
    
    func normalized() -> SCNVector3{
        let mag = magnitude()
        return SCNVector3(x/mag,y/mag,z/mag)
    }
    
    static func +(_ lhs: SCNVector3, _ rhs: SCNVector3) -> SCNVector3{
        return SCNVector3(lhs.x + rhs.x,lhs.y + rhs.y,lhs.z + rhs.z)
    }
    
    static func *(_ lhs: SCNVector3, _ rhs: Float) -> SCNVector3{
        return SCNVector3(lhs.x*rhs,lhs.y*rhs,lhs.z*rhs)
    }
    
    static func -(_ lhs: SCNVector3, _ rhs: SCNVector3) -> SCNVector3{
        return SCNVector3(lhs.x-rhs.x,lhs.y-rhs.y,lhs.z-rhs.z)
    }
}
