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
        createPedigrees()
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
        return pedigrees.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PedigreeListTableCell", for: indexPath) as? PedigreeListTableViewCell else {
            fatalError("Uh oh I suck at coding")
        }
        
        let pedigree = pedigrees[indexPath.row]
        cell.probandLabel.text = "The " + pedigree.getPerson(individualID: pedigree.probandID)!.lastName + " family"

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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let id = segue.identifier {
            switch (id) {
            case "PedigreeSelected":
                let dvc = segue.destination as! PedigreeTableViewController
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    dvc.pedigree = pedigrees[indexPath.row]
                    dvc.navBarTitle = "The " + pedigrees[indexPath.row].getPerson(individualID: pedigrees[indexPath.row].probandID)!.lastName + " Family"
                }
                
            default: break
            }
        }
    }
    

    private func createPedigrees() {
        let p1 = Person(familyID: 1, individualID: 1, fatherID: 0, motherID: 0, genderID: 1, affectedStatus: 1, firstName : "Mark", lastName : "Jones")
        let p2 = Person(familyID: 1, individualID: 2, fatherID: 0, motherID: 0, genderID: 2, affectedStatus: 0, firstName: "Jesse", lastName: "Jones")
        let p3 = Person(familyID: 1, individualID: 3, fatherID: 1, motherID: 2, genderID: 1, affectedStatus: 1, firstName: "George", lastName: "Jones")
        let p4 = Person(familyID: 1, individualID: 4, fatherID: 1, motherID: 2, genderID: 2, affectedStatus: 1, firstName: "Hanna", lastName: "Jones")
        let p5 = Person(familyID: 1, individualID: 5, fatherID: 1, motherID: 2, genderID: 1, affectedStatus: 1, firstName: "Steve", lastName: "Jones")
        
        let family1 = [p1, p2, p3, p4, p5]
        pedigrees.append(Pedigree(people: family1, probandID: 1))
        
        let p6 = Person(familyID: 2, individualID: 1, fatherID: 0, motherID: 0, genderID: 1, affectedStatus: 0, firstName: "Eugene", lastName: "Lewis")
        let p7 = Person(familyID: 2, individualID: 2, fatherID: 0, motherID: 0, genderID: 2, affectedStatus: 0, firstName: "Gloria", lastName: "Lewis")
        let p8 = Person(familyID: 2, individualID: 3, fatherID: 0, motherID: 0, genderID: 1, affectedStatus: 1, firstName: "David", lastName: "Hill")
        let p9 = Person(familyID: 2, individualID: 4, fatherID: 0, motherID: 0, genderID: 2, affectedStatus: 1, firstName: "Elizabeth", lastName: "Hill")
        let p10 = Person(familyID: 2, individualID: 5, fatherID: 1, motherID: 2, genderID: 1, affectedStatus: 0, firstName: "Dan", lastName: "Lewis")
        let p11 = Person(familyID: 2, individualID: 6, fatherID: 3, motherID: 4, genderID: 2, affectedStatus: 1, firstName: "Angela", lastName: "Lewis")
        let p12 = Person(familyID: 2, individualID: 7, fatherID: 5, motherID: 6, genderID: 2, affectedStatus: 1, firstName: "Pineapple", lastName: "Lewis")
        let p13 = Person(familyID: 2, individualID: 8, fatherID: 5, motherID: 6, genderID: 1, affectedStatus: 0, firstName: "Bjork", lastName: "Lewis")
        
        let family2 = [p6, p7, p8, p9, p10, p11, p12, p13]
        pedigrees.append(Pedigree(people: family2, probandID: 1))
        
        let p14 = Person(familyID: 3, individualID: 1, fatherID: 0, motherID: 0, genderID: 1, affectedStatus: 0, firstName: "Maximillion", lastName: "Smith")
        let p15 = Person(familyID: 3, individualID: 2, fatherID: 0, motherID: 0, genderID: 2, affectedStatus: 0, firstName: "Regina", lastName: "Smith")
        let p16 = Person(familyID: 3, individualID: 3, fatherID: 1, motherID: 2, genderID: 1, affectedStatus: 0, firstName: "Yugimoto", lastName: "Smith")
        let p17 = Person(familyID: 3, individualID: 4, fatherID: 1, motherID: 2, genderID: 2, affectedStatus: 0, firstName: "Minnie", lastName: "O'Brian")
        let p18 = Person(familyID: 3, individualID: 5, fatherID: 0, motherID: 0, genderID: 1, affectedStatus: 0, firstName: "Sarah", lastName: "Smith")
        let p19 = Person(familyID: 3, individualID: 6, fatherID: 0, motherID: 0, genderID: 2, affectedStatus: 0, firstName: "Kaiba", lastName: "White")
        let p20 = Person(familyID: 3, individualID: 7, fatherID: 3, motherID: 6, genderID: 2, affectedStatus: 0, firstName: "Betsy Sue", lastName: "O'Brian")
        let p21 = Person(familyID: 3, individualID: 8, fatherID: 4, motherID: 5, genderID: 1, affectedStatus: 0, firstName: "Billy Bob", lastName: "O'Brian")
        let p22 = Person(familyID: 3, individualID: 9, fatherID: 7, motherID: 8, genderID: 1, affectedStatus: 1, firstName: "Brayndyon", lastName: "O'Brian")
        let p23 = Person(familyID: 3, individualID: 10, fatherID: 7, motherID: 8, genderID: 2, affectedStatus: 1, firstName: "Zaiydyien", lastName: "O'Brian")
        
        let family3 = [p14, p15, p16, p17, p18, p19, p20, p21, p22, p23]
        pedigrees.append(Pedigree(people: family3, probandID: 1))
    }
}
