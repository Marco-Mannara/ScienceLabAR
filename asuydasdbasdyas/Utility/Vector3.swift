//
//  Vector3.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 19/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//
import GameplayKit


class Vector3
{
    var x : Float = 0.0
    var y : Float = 0.0
    var z : Float = 0.0
    
    init(_ x: Float, _ y : Float, _ z: Float){
        self.x = x
        self.y = y
        self.z = z
    }
    
    init(_ vector: simd_float3){
        self.x = vector.x
        self.y = vector.y
        self.z = vector.z
    }
    
    func getSimdFloat3() -> simd_float3{
        return simd_float3(x,y,z)
    }
    
    func getScnVector3() -> SCNVector3{
        return SCNVector3(x,y,z)
    }
    
    func magnitude() -> Float {
        return sqrt(x*x + y*y + z*z)
    }
    
    func normalized() -> Vector3{
        let mag = magnitude()
        if mag != 0.0{
            return Vector3(x/mag,y/mag,z/mag)
        }
        else{
            return Vector3(0.0,0.0,0.0)
        }
    }
    
    static func +(_ lhs: Vector3, _ rhs: Vector3) -> Vector3{
        return Vector3(lhs.x + rhs.x,lhs.y + rhs.y,lhs.z + rhs.z)
    }
    
    static func *(_ lhs: Vector3, _ rhs: Float) -> Vector3{
        return Vector3(lhs.x*rhs,lhs.y*rhs,lhs.z*rhs)
    }
    
    func print() -> String{
        return String(format: "x: %f y: %f z: %f",x,y,z)
    }
}
