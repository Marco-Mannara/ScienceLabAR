//
//  SimdFloat3Extension.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 17/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import ARKit

extension simd_float3{
    
    var magnitude : Float {
        return sqrt(x*x + y*y + z*z)
    }
    
    static prefix func -(_ vector: simd_float3) -> simd_float3{
        return simd_float3(-vector.x, -vector.y, -vector.z)
    }
    /*
    func magnitude() -> Float{
        return sqrt(x*x + y*y + z*z)
    }
    */
    func normalized() -> simd_float3{
        let mag = self.magnitude
        return simd_float3(self.x / mag, self.y / mag, self.z / mag)
    }
    
    func distance(_ other: simd_float3) -> Float{
        return (self - other).magnitude
    }
}
