//
//  SpriteKitButton.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 01/05/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import SpriteKit


class SKButtonNode : SKSpriteNode{
    
    var action : (()->Void)?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        print("sprite kit button touches began")
        action?()
    }
}
