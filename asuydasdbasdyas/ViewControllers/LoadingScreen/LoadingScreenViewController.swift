//
//  LoadingScreenViewController.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 04/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit

class LoadingScreenViewController: UIViewController {
    var experimentToLoad : String!
    var experimentImage : UIImage!
    
    @IBOutlet var experimentIcon: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var loadedExperiment : Experiment!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experimentIcon.image = experimentImage
        activityIndicator.startAnimating()
        
        let sceneLoadThread = DispatchQueue(label: "sceneLoad")
        sceneLoadThread.async {
            GameManager.getInstance().sceneManager?.loadExperimentScene(self.experimentToLoad)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "arScene", sender: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
}
