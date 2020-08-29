//
//  SelectionMenuViewController.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 03/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit

class SelectionMenuViewController: UIViewController {
    
    @IBOutlet var experimentCollection: UICollectionView!
    
    var experimentsProps : [ExperimentProperties] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        experimentCollection.delegate = self
        experimentCollection.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        experimentsProps = ExperimentPersistence.fetchAllExperimentProperties()?.sorted(by: { (a, b) -> Bool in
            let res = a.name.compare(b.name).rawValue
            return res < 1
        }) ?? []
        self.navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sceneLoad"{
            if let loadingScreen = segue.destination as? LoadingScreenViewController{
                let selectedIndex = experimentCollection.indexPathsForSelectedItems!.first!
                let experimentProps =  experimentsProps[selectedIndex.row]
                let cell = experimentCollection.cellForItem(at: selectedIndex) as! ExperimentCollectionViewCell
                
                loadingScreen.experimentToLoad = experimentProps.storedName
                loadingScreen.experimentImage = cell.experimentImage.image
            }
        }
    }
}
