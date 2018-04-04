//
//  PedigreeTableViewController.swift
//  HW8
//
//  Created by Austin Toot on 4/2/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import UIKit

class PedigreeTableViewController: UITableViewController {

    var pedigree : Pedigree!
    var navBarTitle : String!
    @IBOutlet weak var navBar: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        navBar.title = navBarTitle
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
        return pedigree.family.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PedigreeTableCell", for: indexPath) as? PedigreeTableViewCell else {
            fatalError("Uh oh I suck at coding")
        }
        let person = pedigree.family[indexPath.row]
        cell.nameLabel.text = person.firstName + " " + person.lastName
        cell.parentsLabel.text = ""
        if person.father != 0 && person.mother != 0 {
            let father = pedigree.getPerson(individualID: person.father)!
            let mother = pedigree.getPerson(individualID: person.mother)!
            cell.parentsLabel.text = father.firstName + " " + father.lastName + ", " + mother.firstName + " " + mother.lastName
        }
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
            case "PersonSelected":
                let dvc = segue.destination as! IndividualViewController
                
                if let indexPath = self.tableView.indexPathForSelectedRow {
                    let person = pedigree.family[indexPath.row]
                    dvc.firstName = person.firstName
                    dvc.lastName = person.lastName
                    dvc.motherID = person.mother
                    dvc.fatherID = person.father
                    dvc.gender = person.gender
                    dvc.affected = person.affected
                    dvc.row = indexPath.row
                }
            case "NewSelected":
                let dvc = segue.destination as! IndividualViewController
                dvc.firstName = ""
                dvc.lastName = ""
                dvc.motherID = 0
                dvc.fatherID = 0
                dvc.gender = 1
                dvc.affected = 0
                //don't set row so it can be tested for in the unwind
                
            default: break
            }
        }
    }
    
    @IBAction func customUnwind( _ unwindSegue: UIStoryboardSegue) {
        if let dvc = unwindSegue.source as? IndividualViewController {
            if let row = dvc.row {
                //if row was set, the editing screen was used to edit an existing family member
                
                pedigree.family[row].firstName = dvc.firstNameText.text!
                pedigree.family[row].lastName = dvc.lastNameText.text!
                guard let motherID = Int(dvc.motherIDText.text!) else {
                    fatalError("invalid mother ID")
                }
                pedigree.family[row].mother = motherID
                
                guard let fatherID = Int(dvc.motherIDText.text!) else {
                    fatalError("invalid father ID")
                }
                pedigree.family[row].father = fatherID
                
                pedigree.family[row].gender = dvc.genderSwitch.isOn ? 2 : 1
                pedigree.family[row].affected = dvc.affectedSwitch.isOn ? 1 : 0
            } else {
                //if row was not set, the editing screen was used to add a new family member
                guard let firstName = dvc.firstNameText.text else {
                    fatalError("No first name")
                }
                
                guard let lastName = dvc.lastNameText.text else {
                    fatalError("No last name")
                }
                
                var fatherID = 0
                if let fid = Int(dvc.fatherIDText.text!) {
                    fatherID = fid
                }
                
                var motherID = 0
                if let mid = Int(dvc.motherIDText.text!) {
                    motherID = mid
                }
                
                let gender = dvc.genderSwitch.isOn ? 2 : 1
                let affected = dvc.affectedSwitch.isOn ? 1 : 0
                
                let person = Person(familyID: pedigree.family[0].family, individualID: pedigree.family.count, fatherID: fatherID, motherID: motherID, genderID: gender, affectedStatus: affected, firstName: firstName, lastName: lastName)
                pedigree.family.append(person)
            }
            self.tableView.reloadData()
        }
    }
}
