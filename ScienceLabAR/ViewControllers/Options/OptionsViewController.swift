//
//  OptionsViewController.swift
//  asuydasdbasdyas
//
//  Created by Marco Mannara on 05/07/2020.
//  Copyright © 2020 Marco Mannara. All rights reserved.
//

import UIKit
import ARKit

class OptionsViewController: UITableViewController {

    private var sectionTitles : [String]!
    private var arOptionLabels : [(label : String, action : ()->Void)]!
    private var otherOptionLabels : [(label: String, action : ()->Void)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sectionTitles = ["Tracking Options","Other"]
        arOptionLabels = [("Retrack Environment", retrackEnvironment)]
        otherOptionLabels = [("Back to Menu", exitToMenu),("Back to experiment", closeMenu)]
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sectionTitles.count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return arOptionLabels.count
        }
        else if section == 1{
            return otherOptionLabels.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell") as! OptionTableViewCell
        if indexPath.section == 0 {
            let entry = arOptionLabels[indexPath.row]
            cell.optionLabel.text = entry.label
            cell.action = entry.action
        }
        if indexPath.section == 1 {
            let entry = otherOptionLabels[indexPath.row]
            cell.optionLabel.text = entry.label
            cell.action = entry.action
        }
        return cell
    }
    
    @objc
    func retrackEnvironment(){
        //print("retrack environment")
        if let arViewController = GameManager.getInstance().viewController as? ARViewController{
            arViewController.retrack()
            dismiss(animated: true, completion: nil)
        }
    }
    
    @objc
    func exitToMenu(){
        //print("exit to menu")
        performSegue(withIdentifier: "mainMenu", sender: self)
    }
    
    
    @objc func closeMenu(){
        dismiss(animated: true, completion: nil)
    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
