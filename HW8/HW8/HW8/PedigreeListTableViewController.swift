//
//  PedigreeListTableViewController.swift
//  HW8
//
//  Created by Austin Toot on 4/2/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import UIKit

class PedigreeListTableViewController: UITableViewController {

    var pedigrees : [Pedigree] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pedigrees.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PedigreeListTableCell", for: indexPath) as? PedigreeListTableViewCell else {
            fatalError("Uh oh I suck at coding")
        }
        
        let pedigree = pedigrees[indexPath.row]
        cell.probandLabel.text = pedigree.getPerson(individualID: pedigree.probandID)!.lastName

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    private func createPedigrees() {
        //placeholder for a real one in the hw
        let p1 = Person(familyID: 1, individualID: 1, fatherID: 0, motherID: 0, genderID: 1, affectedStatus: 1, firstName : "f1", lastName : "l1")
        let p2 = Person(familyID: 1, individualID: 2, fatherID: 0, motherID: 0, genderID: 2, affectedStatus: 0, firstName : "f2", lastName : "l2")
        let p3 = Person(familyID: 1, individualID: 3, fatherID: 0, motherID: 0, genderID: 1, affectedStatus: 0, firstName : "f3", lastName : "l3")
        let p4 = Person(familyID: 1, individualID: 4, fatherID: 1, motherID: 2, genderID: 2, affectedStatus: 1, firstName : "f4", lastName : "l4")
        let p5 = Person(familyID: 1, individualID: 5, fatherID: 3, motherID: 4, genderID: 2, affectedStatus: 1, firstName : "f5", lastName : "l5")
        let p6 = Person(familyID: 1, individualID: 6, fatherID: 3, motherID: 4, genderID: 1, affectedStatus: 0, firstName : "f6", lastName : "l6")
        
        var personArr : [Person] = []
        personArr.append(p1)
        personArr.append(p2)
        personArr.append(p3)
        personArr.append(p4)
        personArr.append(p5)
        personArr.append(p6)
        
        pedigrees.append(Pedigree(people: personArr, probandID: 1))
        
        
    }
}
