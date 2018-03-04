//
//  ViewController.swift
//  pedigree
//
//  Created by Austin Toot on 2/28/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let drawSize = 50
    
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
        
        let pedigreeView = PedigreeView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        self.view.addSubview(pedigreeView)
        
        
        let panGestureRec = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(recognizer:)))

        
        pedigreeView.addGestureRecognizer(panGestureRec)
        
    }
    
    @objc func pan(recognizer: UIPanGestureRecognizer){
        switch recognizer.state{
        case .changed, .ended:
            let translate = recognizer.translation(in: view)
            //specialView.center.x += translate.x
            //specialView.center.y += translate.y
            
            //specialView.center = specialView.center.applying(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: translate.x, ty: translate.y))
            self.view.center = self.view.center.applying(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: translate.x, ty: translate.y))
            recognizer.setTranslation(CGPoint(x:0, y:0), in: view)
            
        default:
            break
            
        }
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

