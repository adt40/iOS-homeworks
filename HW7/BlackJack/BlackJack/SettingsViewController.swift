//
//  SettingsViewController.swift
//  BlackJack
//
//  Created by Austin Toot on 3/19/18.
//  Copyright © 2018 Jing Li. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var numDecksTextField: UITextField!
    @IBOutlet weak var thresholdTextField: UITextField!
    
    var numDecks : Int?
    var threshold : Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let nd = numDecks {
            numDecksTextField.text = String(nd)
        }
        if let t = threshold {
            thresholdTextField.text = String(t)
        }
    }

    @IBAction func donePressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "unwindToGame", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let id = segue.identifier {
            switch id {
            case "Done":
                let dvc = segue.destination as! BJViewController
                if let numDecksString = numDecksTextField.text {
                    if let numDecks = Int(numDecksString) {
                        dvc.numDecks = numDecks
                    }
                }
                if let thresholdString = thresholdTextField.text {
                    if let threshold = Int(thresholdString) {
                        dvc.threshold = threshold as Int
                    }
                }
            default: break
            }
        }
    }
}
