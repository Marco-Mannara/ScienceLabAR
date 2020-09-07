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
    
    private var experimentExplanation : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experimentIcon.image = experimentImage
        activityIndicator.startAnimating()
        
        let sceneLoadThread = DispatchQueue(label: "sceneLoad")
        sceneLoadThread.async {
            GameManager.getInstance().sceneManager?.loadExperimentScene(self.experimentToLoad)
            self.experimentExplanation = ExperimentPersistence.loadExplanation(with: self.experimentToLoad)
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "explanation", sender: self)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "explanation"{
            ExplanationViewController.explanation = experimentExplanation
        //dismiss(animated: false, completion: nil)
        }
    }
}
