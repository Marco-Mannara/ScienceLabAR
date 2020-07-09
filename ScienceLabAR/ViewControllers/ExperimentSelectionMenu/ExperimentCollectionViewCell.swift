//
//  ExperimentCollectionViewCell.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 03/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit

class ExperimentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var experimentNameLabel: UILabel!
    @IBOutlet var experimentImage: UIImageView!
    
    override func awakeFromNib() {
        layer.borderColor = CGColor(srgbRed: 0.7,green: 0.7,blue: 0.7,alpha: 0.8)
        layer.borderWidth = 1.0
        layer.cornerRadius = 10
        
        super.awakeFromNib()
    }
}
