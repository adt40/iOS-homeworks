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
}
