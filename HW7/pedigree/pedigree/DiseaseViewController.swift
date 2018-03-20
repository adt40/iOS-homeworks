//
//  DiseaseViewController.swift
//  pedigree
//
//  Created by Austin Toot on 3/19/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import UIKit

class DiseaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func switchChanged(_ sender: UISwitch) {
        let vc = self.tabBarController?.viewControllers![0] as! ViewController
        var family = vc.pedigree!.family
        for i in 0..<family.count {
            if family[i].individual == sender.tag {
                if sender.isOn {
                    family[i].affected = 1
                } else {
                    family[i].affected = 0
                }
                break
            }
        }
        let newPedigree = Pedigree(people: family)
        vc.pedigree = newPedigree
        vc.pedigreeView.pedigree = newPedigree
        vc.pedigreeView.setNeedsDisplay()
    }
}
