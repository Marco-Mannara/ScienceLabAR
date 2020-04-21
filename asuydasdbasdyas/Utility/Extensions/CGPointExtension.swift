//
//  CGPointExtension.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 21/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//
import GameplayKit

extension CGPoint
{
    func toSimdFloat2() -> simd_float2{
        return simd_float2(Float(x),Float(y))
    }
}


