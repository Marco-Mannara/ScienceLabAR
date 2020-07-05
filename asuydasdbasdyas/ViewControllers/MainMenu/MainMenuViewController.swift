//
//  MainMenuViewController.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 04/05/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {
    
    override public var shouldAutorotate: Bool{
           return true
       }
       
       override public var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation{
           return .landscapeRight
       }
       
       override public var supportedInterfaceOrientations: UIInterfaceOrientationMask{
           return .landscapeRight
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let value = UIInterfaceOrientation.landscapeRight.rawValue
        UIDevice.current.setValue(value, forKey: "orientation")
        
        if let navBar = navigationController?.navigationBar{
            navBar.setBackgroundImage(UIImage(), for: .default)
            navBar.shadowImage = UIImage()
        }
        
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    */
}
