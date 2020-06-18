//
//  File.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 14/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//
import ARKit

extension simd_float4x4
{
    init(translation vector: SIMD3<Float>) {
        self.init(SIMD4<Float>(1, 0, 0, 0),
                  SIMD4<Float>(0, 1, 0, 0),
                  SIMD4<Float>(0, 0, 1, 0),
                  SIMD4<Float>(vector.x, vector.y, vector.z, 1))
    }
    
    var translation : simd_float3 {
        return getPosition()
    }
    var front : simd_float3 {
        return simd_make_float3(self.columns.2)
    }
    var up : simd_float3 {
        return simd_make_float3(self.columns.1)
    }
    var right : simd_float3 {
        return simd_make_float3(self.columns.0)
    }
    
    
    func getPosition() -> simd_float3{
        let lastCol = self.columns.3
        return SIMD3<Float>(lastCol.x,lastCol.y,lastCol.z)
    }
    
    func getPositionVector() -> SCNVector3{
        let trans = getPosition()
        return SCNVector3(trans.x,trans.y,trans.z)
    }
    
    func setRotation(_ euler : SCNVector3){
    }
    
    func getRotation(){
        
    }
}
