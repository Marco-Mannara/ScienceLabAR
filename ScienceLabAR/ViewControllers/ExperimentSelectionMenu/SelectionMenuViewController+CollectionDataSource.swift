//
//  SelectionMenuViewController+CollectionDataSource.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 03/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import Foundation
import UIKit

extension SelectionMenuViewController : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return experimentsProps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "experimentCell", for: indexPath) as! ExperimentCollectionViewCell
        let properties = experimentsProps[indexPath.row]
        
        cell.experimentNameLabel.text = properties.name
        
        if let imageName =  properties.imageName{
            cell.experimentImage.image = UIImage(named: imageName)
        }
        else{
            print("No image for experiment cell")
        }
        return cell
    }
}
