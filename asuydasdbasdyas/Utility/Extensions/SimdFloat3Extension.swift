//
//  SimdFloat3Extension.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 17/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import ARKit

extension simd_float3{
    
    static func flip(_ vector: simd_float3) -> simd_float3{
        return simd_float3(-vector.x, -vector.y, -vector.z)
    }
    
    mutating func add(_ other: simd_float3){
        self.x += other.x
        self.y += other.y
        self.z += other.z
    }
    
    mutating func sub(_ other: simd_float3){
        self.add(simd_float3.flip(other))
    }
    
    static func addition(_ lhs: simd_float3, _ rhs: simd_float3) -> simd_float3{
        return simd_float3(lhs.x + rhs.x, lhs.y + rhs.y, lhs.z + rhs.z)
    }
    
    static func subatraction(_ lhs: simd_float3, _ rhs: simd_float3) -> simd_float3{
        return addition (lhs, simd_float3.flip(rhs))
    }
}
