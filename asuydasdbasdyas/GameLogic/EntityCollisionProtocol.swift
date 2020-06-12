//
//  EntityCollisionDelegate.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 07/05/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import SceneKit


protocol EntityCollisionProtocol{
    func collisionBegin(_ contact : SCNPhysicsContact, _ otherNode: SCNNode)
    func collisionUpdate(_ contact : SCNPhysicsContact, _ otherNode: SCNNode)
    func collisionEnd(_ contact: SCNPhysicsContact, _ otherNode: SCNNode)
}
