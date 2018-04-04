//
//  IndividualViewController.swift
//  HW8
//
//  Created by Austin Toot on 4/2/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import UIKit

class IndividualViewController: UIViewController {

    @IBOutlet weak var firstNameText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var motherIDText: UITextField!
    @IBOutlet weak var fatherIDText: UITextField!
    @IBOutlet weak var genderSwitch: UISwitch!
    @IBOutlet weak var affectedSwitch: UISwitch!
    
    var firstName : String?
    var lastName : String?
    var motherID : Int?
    var fatherID : Int?
    var gender : Int?
    var affected : Int?
    var row : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let fn = firstName {
            firstNameText.text = fn
        }
        if let ln = lastName {
            lastNameText.text = ln
        }
        if let mid = motherID {
            motherIDText.text = String(mid)
        }
        if let fid = fatherID {
            fatherIDText.text = String(fid)
        }
        if let g = gender {
            if g == 1 {
                genderSwitch.isOn = false
            } else {
                genderSwitch.isOn = true
            }
        }
        if let a = affected {
            if a == 0 {
                affectedSwitch.isOn = false
            } else {
                affectedSwitch.isOn = true
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
