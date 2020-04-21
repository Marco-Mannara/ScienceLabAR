//
//  ControllerButton.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 21/04/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import GameplayKit

class ControllerButton {
    
    var size: simd_float2
    var position: simd_float2
    private lazy var bounds : simd_float4 = simd_float4(position.x - size.x / 2,
                                                        position.y - size.y / 2,
                                                        position.x + size.x / 2,
                                                        position.y + size.y / 2)
    
    init(_ position:simd_float2, size: simd_float2){
        self.size = size
        self.position = position
    }
    
    func checkHit(_ point: simd_float2) -> Bool{
        return point.x >= bounds.x && point.x <= bounds.z && point.y >= bounds.y && point.y <= bounds.w
    }
}
