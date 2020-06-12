//
//  SCNNodeExtension.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 12/06/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SceneKit

extension SCNNode {
    func setHighlighted( _ highlighted : Bool = true, _ highlightedBitMask : Int = 2 ) {
        categoryBitMask = highlightedBitMask
        for child in self.childNodes {
            child.setHighlighted()
        }
    }
}
