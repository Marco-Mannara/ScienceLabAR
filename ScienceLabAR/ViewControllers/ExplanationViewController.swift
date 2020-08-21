//
//  ExplanationViewController.swift
//  ScienceLabAR
//
//  Created by Marco Mannara on 17/08/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit

class ExplanationViewController: UIViewController {
    
    @IBOutlet var gotitButton: UIButton!
    @IBOutlet var explanationLabel: UILabel!
    var explanation : String!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gotitButton.layer.borderColor = CGColor(srgbRed: 0.7,green: 0.7,blue: 0.7,alpha: 0.8)
        gotitButton.layer.borderWidth = 0.9
        gotitButton.layer.cornerRadius = 7
        
        explanationLabel.numberOfLines = 0
        explanationLabel.text = explanation
        explanationLabel.sizeToFit()
        // Do any additional setup after loading the view.
    }

    
    @IBAction func onButtonPressed(_ sender: Any) {
        performSegue(withIdentifier: "game", sender: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
