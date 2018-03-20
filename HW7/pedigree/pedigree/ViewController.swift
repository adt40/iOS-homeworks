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
    var pedigreeView : PedigreeView!
    var pedigree : Pedigree?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var p1 = Person(familyID: 1, individualID: 1, fatherID: 0, motherID: 0, genderID: 1,  affectedStatus: 1)
        var p2 = Person(familyID: 1, individualID: 2, fatherID: 0, motherID: 0, genderID: 2, affectedStatus: 0)
        var p3 = Person(familyID: 1, individualID: 3, fatherID: 0, motherID: 0, genderID: 1, affectedStatus: 0)
        var p4 = Person(familyID: 1, individualID: 4, fatherID: 1, motherID: 2, genderID: 2, affectedStatus: 1)
        var p5 = Person(familyID: 1, individualID: 5, fatherID: 3, motherID: 4, genderID: 2, affectedStatus: 1)
        var p6 = Person(familyID: 1, individualID: 6, fatherID: 3, motherID: 4, genderID: 1, affectedStatus: 0)
        
        var personArr : [Person] = []
        personArr.append(p1)
        personArr.append(p2)
        personArr.append(p3)
        personArr.append(p4)
        personArr.append(p5)
        personArr.append(p6)
        
        pedigree = Pedigree(people: personArr)
        
        pedigreeView = PedigreeView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: self.view.bounds.height))
        pedigreeView.pedigree = pedigree
        self.view.addSubview(pedigreeView)
        
        
        let panGestureRec = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan(recognizer:)))
        let zoomGenstureRec = UIPinchGestureRecognizer(target: self, action: #selector(ViewController.zoom(recognizer:)))
        pedigreeView.addGestureRecognizer(panGestureRec)
        pedigreeView.addGestureRecognizer(zoomGenstureRec)
        
    }
    
    @objc func pan(recognizer: UIPanGestureRecognizer){
        switch recognizer.state{
        case .changed, .ended:
            let translate = recognizer.translation(in: view)
            pedigreeView.center = pedigreeView.center.applying(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: translate.x, ty: translate.y))
            recognizer.setTranslation(CGPoint(x:0, y:0), in: view)
            
        default:
            break
            
        }
    }
    
    @objc func zoom(recognizer: UIPinchGestureRecognizer) {
        switch recognizer.state {
        case .changed, .ended:
            let scale = recognizer.scale
            pedigreeView.bounds = pedigreeView.bounds.applying(CGAffineTransform(a: scale, b: 0, c: 0, d: scale, tx: 0, ty: 0))
            recognizer.scale = 1
        default :
            break
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

