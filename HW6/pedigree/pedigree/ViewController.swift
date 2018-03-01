//
//  ViewController.swift
//  pedigree
//
//  Created by Austin Toot on 2/28/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let p1 = Person(familyID: 1, individualID: 1, fatherID: 0, motherID: 0, genderID: 1,  affectedStatus: 1)
        let p2 = Person(familyID: 1, individualID: 2, fatherID: 0, motherID: 0, genderID: 2, affectedStatus: 0)
        let p3 = Person(familyID: 1, individualID: 3, fatherID: 0, motherID: 0, genderID: 1, affectedStatus: 0)
        let p4 = Person(familyID: 1, individualID: 4, fatherID: 1, motherID: 2, genderID: 2, affectedStatus: 1)
        let p5 = Person(familyID: 1, individualID: 5, fatherID: 3, motherID: 4, genderID: 2, affectedStatus: 1)
        let p6 = Person(familyID: 1, individualID: 6, fatherID: 3, motherID: 4, genderID: 1, affectedStatus: 0)
        
        var personArr : [Person] = []
        personArr.append(p1)
        personArr.append(p2)
        personArr.append(p3)
        personArr.append(p4)
        personArr.append(p5)
        personArr.append(p6)
        
        let pedigree = Pedigree(people: personArr)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func drawSquare(gridLocation : GridLocation, isAffected : Bool) {
        
    }
    func drawCircle(gridLocation : GridLocation, isAffected : Bool) {
        
    }
    func drawT(gridLocation : GridLocation) {
        
    }
    func drawInvertedT(gridLocation : GridLocation) {
        
    }
    func drawLeftDown(gridLocation : GridLocation) {
        
    }
    func drawRightDown(gridLocation : GridLocation) {
        
    }
    
    
}

