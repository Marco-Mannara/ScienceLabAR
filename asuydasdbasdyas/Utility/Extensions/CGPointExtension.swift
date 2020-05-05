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

    init(_ x: Float, _ y: Float){
        self.init()
        self.x = CGFloat(x)
        self.y = CGFloat(y)
    }
    
    init(_ x: Double, _ y: Float){
        self.init()
        self.x = CGFloat(x)
        self.y = CGFloat(y)
    }

    func toSimdFloat2() -> simd_float2{
        return simd_float2(Float(x),Float(y))
    }
    
    static func screenToSpriteSceneCoordinates(_ point: CGPoint) -> CGPoint{
        return CGPoint(x: point.x - UIScreen.main.bounds.width / 2,y: UIScreen.main.bounds.height / 2 - point.y)
    }
    
    
    static func -(_ lhs: CGPoint, rhs: CGPoint) -> CGPoint{
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func -(_ lhs: CGPoint, rhs: simd_float2) -> CGPoint{
        return CGPoint(x: lhs.x - CGFloat(rhs.x),y: lhs.y - CGFloat(rhs.y))
    }
    
    static prefix func -(_ lhs: CGPoint) -> CGPoint{
        return CGPoint( x: -lhs.x, y: -lhs.y)
   }
}


