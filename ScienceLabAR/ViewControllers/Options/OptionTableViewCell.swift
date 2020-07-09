//
//  OptionTableViewCell.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 05/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet var optionLabel: UILabel!
    var action : (()->Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        action()
    }
}
