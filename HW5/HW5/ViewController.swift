//
//  ViewController.swift
//  HW5
//
//  Created by Austin Toot on 2/24/18.
//  Copyright © 2018 Austin Toot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var decimalTextField: UITextField!
    @IBOutlet weak var binaryLabel: UILabel!
    @IBOutlet weak var enqueueTextField: UITextField!
    @IBOutlet weak var dequeueLabel: UILabel!
    @IBOutlet weak var queueTextView: UITextView!
    
    var queue = Queue<Int>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func enqueuePressed(_ sender: UIButton) {
        if let enqueueText = enqueueTextField.text {
            if let enqueueVal = Int(enqueueText) {
                queue.enqueue(enqueueVal)
            }
        }
    }
    
    @IBAction func dequeuePressed(_ sender: UIButton) {
        if let dequeue = queue.dequeue() {
            dequeueLabel.text = String(describing: dequeue) + " has been removed"
        }
    }
    
    @IBAction func displayAllPressed(_ sender: UIButton) {
        var tempQueue = queue
        var text = ""
        while !tempQueue.isEmpty() {
            let line = String(describing: tempQueue.dequeue()!) + "\n"
            text += line
        }
        queueTextView.text = text
    }
    
    @IBAction func convertPressed(_ sender: UIButton) {
        if let decimalText = decimalTextField.text {
            if var decimal = Int(decimalText) {
                var stack = Stack<Int>()
                while decimal != 0 {
                    let remainder = decimal % 2
                    decimal = (decimal - remainder) / 2
                    stack.push(remainder)
                }
                var binaryText = ""
                while !stack.isEmpty() {
                    binaryText += String(describing: stack.pop()!)
                }
                binaryLabel.text = binaryText
            }
        }
    }
}

