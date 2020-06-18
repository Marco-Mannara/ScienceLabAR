//
//  NodePool.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 19/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit


class NodePool{
    
    private var avaiablePool : [SCNNode]
    private var busyPool : [SCNNode]
    private var quantity : Int
    
    init(_ node : SCNNode, _ rootNode : SCNNode,_ quantity : Int){
        self.avaiablePool = []
        self.busyPool = []
        self.quantity = quantity
        
        for _ in [0 ... quantity]{
            let clone = node.clone()
            avaiablePool.append(clone)
            clone.isHidden = true
            rootNode.addChildNode(clone)
        }
    }
    
    func request() -> SCNNode?{
        if avaiablePool.count > 0{
            let node = avaiablePool.removeLast()
            busyPool.append(node)
            return node
        }
        return nil
    }
    
    func release(_ node : SCNNode){
        let node = busyPool.remove(at: busyPool.firstIndex(of: node)!)
        avaiablePool.append(node)
    }
}
